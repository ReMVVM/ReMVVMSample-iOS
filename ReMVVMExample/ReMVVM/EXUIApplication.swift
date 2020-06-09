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
                                  state: ApplicationState = .empty) -> Store<EXApplicationState> {

        EXUIApplication.setupStyles()




        let tabConfig = TabBarConfig(height: 100,
                                     configureTabBar: { tabBar in
                                        tabBar.barTintColor = .red
                                     },
                                     configureItems: .custom { tabs in
                                        let stack = UIStackView()
                                        stack.distribution = .fillEqually

                                        let controls: [UIControl] = tabs.map {
                                            let item = TabBarItemView(frame: .zero)
                                            item.viewModel = $0.any
                                            return item
                                        }
                                        controls.forEach(stack.addArrangedSubview)

                                        return (stack, controls)
                                     },
                                     tabType: EXNavigationTab.self)

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
