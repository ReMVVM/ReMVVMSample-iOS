//
//  UIState.swift
//  ReMVVMExt
//
//  Created by Grzegorz Jurzak, Daniel Plachta, Dariusz Grzeszczak.
//  Copyright © 2019 HYD. All rights reserved.
//

import UIKit
import Loaders

public struct UIStateConfig {
    let initial: () -> UIViewController
    let navigation: () -> UINavigationController
    let tabBarConfigs: [TabBarConfig]
    let navigationBarHidden: Bool

    public init(initial: @escaping () -> UIViewController,
                customNavigation: (() -> UINavigationController)? = nil,
                tabBarConfigs: [TabBarConfig] = [],
                navigationBarHidden: Bool = true
        ) {

        self.initial = initial
        self.navigation = customNavigation ?? { UINavigationController() }
        self.tabBarConfigs = tabBarConfigs
        self.navigationBarHidden = navigationBarHidden
    }
}

public protocol NavigationContainer {
    var topNavigation: UINavigationController? { get }
}

public final class UIState {

    private let window: UIWindow
    private let uiStateMainController: UINavigationController

    public internal(set) var modalControllers: [UIViewController] = []

    public let config: UIStateConfig

    public init(window: UIWindow, config: UIStateConfig) {
        self.window = window
        self.config = config

        uiStateMainController = config.navigation()
        uiStateMainController.view.bounds = window.bounds
        uiStateMainController.setNavigationBarHidden(config.navigationBarHidden, animated: false)

        window.rootViewController = uiStateMainController

        setRoot(controller: config.initial(), animated: false, navigationBarHidden: config.navigationBarHidden)
    }

    public func setRoot(controller: UIViewController, animated: Bool, navigationBarHidden: Bool) {
        if uiStateMainController.isNavigationBarHidden != navigationBarHidden {
            uiStateMainController.setNavigationBarHidden(navigationBarHidden, animated: animated)
        }
        uiStateMainController.setViewControllers([controller], animated: animated)
    }

    public var rootViewController: UIViewController {
        return uiStateMainController.viewControllers[0]
    }

    public var navigationController: UINavigationController? {
        return modalControllers.compactMap { $0 as? UINavigationController }.last ?? (rootViewController as? NavigationContainer)?.topNavigation ?? uiStateMainController
    }

    private var topPresenter: UIViewController {
        return modalControllers.last ?? rootViewController
    }

    public func present(_ viewController: UIViewController, animated: Bool) {
        topPresenter.present(viewController, animated: animated, completion: { [topPresenter] in
            topPresenter.setNeedsStatusBarAppearanceUpdate()
        })
        modalControllers.append(viewController)
    }

    public func dismissAll(animated: Bool) {
        dismiss(animated: animated, number: Int.max)
    }

    public func dismiss(animated: Bool, number: Int = 1) {
        let number = modalControllers.count >= number ? number : modalControllers.count
        guard number > 0 else { return }
        modalControllers.removeLast(number)
        topPresenter.dismiss(animated: animated, completion: { [topPresenter] in
            topPresenter.setNeedsStatusBarAppearanceUpdate()
        })
    }
}
