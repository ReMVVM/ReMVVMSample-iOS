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

struct EXUIApplication {

    public static func initialize(with window: UIWindow,
                                  middlewares: [AnyMiddleware],
                                  state: EXApplicationState = .empty) -> Store<EXApplicationState> {

        EXUIApplication.setupStyles()

        let uiStateConfig = UIStateConfig(initial: {

            let storyboard = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main)
            guard let mainViewController = storyboard.instantiateInitialViewController() else {
                fatalError("LaunchScreen not found")
            }

            return mainViewController

        }, customNavigation: EXNavigationController.init, customTabBar: nil, navigationBarHidden: true)

        let reducer = AnyReducer { state, action -> EXApplicationState in
            return EXApplicationState(
                navigationTree: NavigationTreeReducer.reduce(state: state.navigationTree, with: action),
                currentTab: NavigationTabReducer.reduce(state: state.currentTab, with: action),
                userState: UserStateReducers.reduce(state: state.userState, with: action))
        }

        let stateMappers: [StateMapper<EXApplicationState>] = [
            StateMapper<EXApplicationState> { state in
                return state.userState
            }
        ]

//        TabBarConfig.tabBarViewController = {
//            return TabBar.instantiateInitialViewController()
//        }

        let store = ReMVVMExtension.initialize(with: window,
                                               uiStateConfig: uiStateConfig,
                                               state: state,
                                               stateMappers: stateMappers,
                                               reducer: reducer,
                                               middleware: middlewares)

        return store
    }

    private static func setupStyles() { }

}
