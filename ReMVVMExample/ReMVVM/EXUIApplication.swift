//
//  EXUIApplication.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 22/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt
import UIKit

extension EXNavigationTab {

    var title: String {
        return self.rawValue
    }

    var iconImageName: String {
        switch self {
        case .todo:
            return "list"
        case .stack:
            return "transfer"
        case .profile:
            return "user"
            case .todo1:
                return "list"
            case .stack1:
                return "transfer"
            case .profile1:
                return "user"
        }
    }

    var iconImageNameActive: String {
        return iconImageName
    }

    var iconImage: UIImage? {
        return resizeImage(image: UIImage(named: iconImageName), newWidth: 30)
    }

    var iconImageActive: UIImage? {
        return resizeImage(image: UIImage(named: iconImageNameActive), newWidth: 30)
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

    static func configure(tabs: [EXNavigationTab]) -> (UIView, [UIControl]) {
        let stack = UIStackView()
         stack.distribution = .fillEqually

         let controls: [UIControl] = tabs.map {
             let item = TabBarItemView(frame: .zero)
             item.title = $0.title
             item.iconImage = $0.iconImage
             item.iconImageActive = $0.iconImageActive
             return item
         }
         controls.forEach(stack.addArrangedSubview)

         return (stack, controls)
    }

    static func configure(tabs: [(tab: EXNavigationTab, uiTab: UITabBarItem)]) -> UIView? {

        tabs.forEach {
            $0.uiTab.title = $0.tab.title
            $0.uiTab.image = $0.tab.iconImage
            $0.uiTab.selectedImage = $0.tab.iconImageActive
        }
        return nil
    }
}

struct EXUIApplication {

    public static func initialize(with window: UIWindow,
                                  middlewares: [AnyMiddleware],
                                  state: ApplicationState = .empty) -> Store<EXApplicationState> {

        EXUIApplication.setupStyles()




        guard let tabConfig = try? TabBarConfig(height: 100,
                                                configureTabBar: { tabBar in
                                                    tabBar.barTintColor = .red
                                                },
                                                configureItems: .custom(EXNavigationTab.configure))
        else { fatalError("Cannot initialize TabBarConfig") }
        
//        guard let tabConfig = try? TabBarConfig(configureItems: .uiTabBar(EXNavigationTab.configure)) else {
//            fatalError("Cannot initialize TabBarConfig")
//        }

        let uiStateConfig = UIStateConfig(initial: {

            let storyboard = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main)
            guard let mainViewController = storyboard.instantiateInitialViewController() else {
                fatalError("LaunchScreen not found")
            }

            return mainViewController

        }, customNavigation: EXNavigationController.init, tabBarConfigs: [tabConfig], navigationBarHidden: true)

        let reducer = AnyReducer { state, action -> EXApplicationState in
            return EXApplicationState(
                appState: ApplicationState(userState: UserStateReducers.reduce(state: state.appState.userState, with: action)),
                navigationTree: NavigationTreeReducer.reduce(state: state.navigationTree, with: action)//,
                //currentTab: NavigationTabReducer<EXNavigationTab>.reduce(state: state.currentTab, with: action)
            )
        }

        let stateMappers: [StateMapper<EXApplicationState>] = [
            StateMapper<EXApplicationState> { state in
                return state.appState.userState
            }
        ]

//        TabBarConfig.tabBarViewController = {
//            return TabBar.instantiateInitialViewController()
//        }

        let store = ReMVVMExtension.initialize(with: window,
                                               uiStateConfig: uiStateConfig,
                                               state: EXApplicationState(appState: state),
                                               stateMappers: stateMappers,
                                               reducer: reducer,
                                               middleware: middlewares)

        return store
    }

    private static func setupStyles() { }

}
