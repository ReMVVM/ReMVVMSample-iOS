//
//  TabBarViewController.swift
//  BNCommon
//
//  Created by Grzegorz Jurzak on 12/02/2019.
//  Copyright © 2019 HYD. All rights reserved.
//

import Loaders
import ReMVVM
import RxCocoa
import RxSwift
import UIKit


public struct TabBarConfig {

    let height: CGFloat?
    let configureItems: ItemsConfigurator<AnyNavigationTab>?
    let configureTabBar: ((UITabBar) -> Void)?

    let all: [AnyNavigationTab]

    public init<Tab>(height: CGFloat? = nil,
                     configureTabBar: ((UITabBar) -> Void)? = nil,
                     configureItems: ItemsConfigurator<Tab>? = nil,
                     tabType: Tab.Type = Tab.self) where Tab: CaseIterableNavigationTab {
        self.height = height
        self.configureTabBar = configureTabBar
        self.configureItems = configureItems?.any
        all = Tab.allCases.any
    }



    public  enum ItemsConfigurator<Tab> {
        case uiTabBar(([(Tab, UITabBarItem)]) -> UIView?)
        case custom(([Tab]) -> (UIView, [UIControl]))

        var any: ItemsConfigurator<AnyNavigationTab> {
            switch self {
            case .uiTabBar(let creator):
                return .uiTabBar { creator($0.map { ($0.0.base as! Tab, $0.1) }) }
            case .custom(let creator):
                return .custom { creator($0.map { $0.base as! Tab }) }
            }
        }
    }

//    enum ItemsCreator<Tab> {
//        case tabBarItem(([Tab]) -> [UITabBarItem])
//        case controlItem(([Tab]) -> [UIControl])
//
//        var any: ItemsCreator<AnyNavigationTab> {
//            switch self {
//            case .tabBarItem(let creator):
//                return .tabBarItem { creator($0.compactMap { $0.base as? Tab }) }
//            case .controlItem(let creator):
//                return .controlItem { creator($0.compactMap { $0.base as? Tab }) }
//            }
//        }
//    }

}

private class TabBar: UITabBar {

    var customView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            guard let customView = customView else { return }
            customView.frame = bounds
            addSubview(customView)
        }
    }

    var controlItems: [UIControl]?

    var height: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        customView?.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setItems(_ items: [UITabBarItem]?, animated: Bool) {

        super.setItems(items, animated: animated)
        guard controlItems != nil else { return }
        subviews
            .compactMap { $0 as? UIControl }
            .filter { $0 != customView }
            .forEach { $0.removeFromSuperview() }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        if let height = height {
            size.height = height
        }
        return size
    }

    var _selectedItem: UITabBarItem? {
        didSet {
            if  _selectedItem != oldValue,
                let tabBarItem = _selectedItem as? TabBarItem,
                let control = tabBarItem.controlItem {

                controlItems?.forEach {
                    $0.isSelected = $0 == control
                }
            }
        }
    }

    override var selectedItem: UITabBarItem? {
        set {
            super.selectedItem = newValue
            _selectedItem = newValue
        }

        get {
            _selectedItem
        }
    }
}

class TabBarItem: UITabBarItem {

    let navigationTab: AnyNavigationTab
    let controlItem: UIControl?

    init(navigationTab: AnyNavigationTab, controlItem: UIControl?) {
        self.navigationTab = navigationTab
        self.controlItem = controlItem
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContainerViewController: UIViewController, NavigationContainer {
    let topNavigation: UINavigationController?

    init() {
        let topNavigation = UINavigationController()
        self.topNavigation = topNavigation
        super.init(nibName: nil, bundle: nil)

        topNavigation.willMove(toParent: self)
        addChild(topNavigation)
        view.addSubview(topNavigation.view)
        topNavigation.didMove(toParent: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


open class TabBarViewController: UITabBarController, NavigationContainer, ReMVVMDriven {

    init(uiStateConfig: UIStateConfig?) {
        self.uiStateConfig = uiStateConfig

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var containers: [ContainerViewController]? {
        viewControllers?.compactMap { $0 as? ContainerViewController }
    }

    public var topNavigation: UINavigationController? {
        guard selectedIndex >= 0 && selectedIndex < containers?.count ?? 0 else { return nil }
        return containers?[selectedIndex].topNavigation
    }

    private var uiStateConfig: UIStateConfig?
    private var config: TabBarConfig?

    @Provided private var viewModel: TabBarViewModel?

    override open var childForStatusBarStyle: UIViewController? {
        return topNavigation?.topViewController
    }

    private func findTableView(for view: UIView) -> UITableView? {
        if let table = view as? UITableView {
            return table
        }

        for v in view.subviews {
            if let found = findTableView(for: v) {
                return found
            }
        }

        return nil
    }

    private var customTabBar: TabBar { return tabBar as! TabBar}
    private let disposeBag = DisposeBag()
    open override func viewDidLoad() {
        setValue(TabBar(), forKey: "tabBar")

        super.viewDidLoad()
        delegate = self

        if let top = moreNavigationController.topViewController {
            if let table = findTableView(for: top.view) {
                print(table)
                table.delegate = self
            }
        }

        guard let viewModel = viewModel else { return }

        viewModel.items.subscribe(onNext: { [unowned self] items in
            self.setup(items: items)
        }).disposed(by: disposeBag)

        viewModel.selected.subscribe(onNext: { [unowned self] item in
            self.setup(current: item)
        }).disposed(by: disposeBag)
    }

    private func setup(items: [AnyNavigationTab]) {

        config = uiStateConfig?.tabBarConfigs.first { $0.all == items }
        customTabBar.height = config?.height
        config?.configureTabBar?(tabBar)

        let tabItems: [UITabBarItem]
        if case let .custom(creator) = config?.configureItems {
            let created = creator(items)
            let customView = created.0
            let controlItems = created.1

            controlItems.enumerated().forEach { index, elem in
                elem.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] in
                    if let viewController = self.viewControllers?[index] {
                        self.sendAction(for: viewController)
                    }
                }).disposed(by: disposeBag)
            }

            tabItems = zip(items, controlItems).map {
                TabBarItem(navigationTab: $0, controlItem: $1)
            }

            customTabBar.customView = customView
            customTabBar.controlItems = controlItems

            moreNavigationController.navigationBar.isHidden = true

        } else {
            let tabBarItems: [TabBarItem] = items.map { item in

                let tabItem = TabBarItem(navigationTab: item, controlItem: nil)
                tabItem.title = item.title
                tabItem.image = UIImage(data: item.iconImage)
                tabItem.selectedImage = UIImage(data: item.iconImageActive)
                return tabItem
            }

            tabItems = tabBarItems

            if case let .uiTabBar(creator) = config?.configureItems {
                let customView = creator(tabBarItems.map { ($0.navigationTab, $0) })
                customTabBar.customView = customView
                customTabBar.controlItems = nil
            } else {
                customTabBar.customView = nil
                customTabBar.controlItems = nil
            }

            moreNavigationController.navigationBar.isHidden = false
        }



        viewControllers = tabItems.map { tab in
            let controller = ContainerViewController()
            controller.tabBarItem = tab
            return controller
        }
    }

    private func resizeImage(image: UIImage?, newWidth: CGFloat) -> UIImage? {

        guard let image = image else {  return nil }

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    private func setup(current: AnyNavigationTab) {
        let selected = viewControllers?.first {
            guard let tab = $0.tabBarItem as? TabBarItem else { return false }
            return current == tab.navigationTab
        }

        guard selected != nil else { return }
        selectedViewController = selected
        customTabBar._selectedItem = selectedViewController?.tabBarItem
    }

    private func sendAction(for viewController: UIViewController) {
        guard let tab = viewController.tabBarItem as? TabBarItem else { return }
        remvvm.dispatch(action: tab.navigationTab.action)
    }

    open override var selectedIndex: Int {
        didSet {
            print(index)
        }
    }

    open override var selectedViewController: UIViewController? {
        didSet {
            print(selectedViewController)
        }
    }
}

extension TabBarViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        sendAction(for: viewControllers![indexPath.item + 4])
        return nil
    }
}

extension TabBarViewController: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if viewController as? ContainerViewController == nil {
            return true
        } else {
            DispatchQueue.main.async {
                self.sendAction(for: viewController)
            }
            return false
        }
    }
}
