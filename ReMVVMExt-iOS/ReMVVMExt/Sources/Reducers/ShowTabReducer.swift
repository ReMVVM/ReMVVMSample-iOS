//
//  ShowTabReducer.swift
//  ReMVVMExt
//
//  Created by DGrzegorz Jurzak, Daniel Plachta, Dariusz Grzeszczak.
//  Copyright © 2019. All rights reserved.
//

import Loaders
import ReMVVM
import UIKit

struct ShowOnTabReducer: Reducer {

    public static func reduce(state: NavigationRoot, with action: ShowOnTab) -> NavigationRoot {

        let current = action.tab
        var stacks: [(AnyNavigationTab, [ViewModelFactory])]
        if action.all == state.tree.stacks.map({ $0.0 }) { //check the type is the same
            stacks = state.tree.stacks.map {
                //TODO add second tap (make it configurable)
                guard $0.0 == current, $0.1.isEmpty else { return $0 }
                return ($0.0, [action.controllerInfo.factory])
            }
        } else {
            stacks = action.all.map {
                guard $0 == current else { return ($0, []) }
                return ($0, [action.controllerInfo.factory])
            }
        }
        let tree = NavigationTree(current: current, stacks: stacks)
        return NavigationRoot(tree: tree, modals: [])
    }
}

public struct ShowOnTabMiddleware: AnyMiddleware {

    public let uiState: UIState

    public init(uiState: UIState) {
        self.uiState = uiState
    }

    public func onNext<State>(for state: State, action: StoreAction, interceptor: Interceptor<StoreAction, State>, dispatcher: Dispatcher) where State : StoreState {

        guard let navigationState = state as? NavigationTreeContainingState, let tabAction = action as? ShowOnTab else {
            interceptor.next(action: action)
            return
        }

//TODO add second tap
//        if let rootState = state as? NavigationTreeContainingState, rootState.navigationTree.tree.stack.count > 1
//            && navigationState.navigationTree.tree.current == tabAction.tab.any {
//            interceptor.next(action: action) { [uiState] _ in
//                (uiState.rootViewController as? TabBarViewController)?
//                    .topNavigation?.popToRootViewController(animated: true)
//            }
//            return
//        }

//TODO
        guard navigationState.navigationTree.tree.current != tabAction.tab else { return }

        interceptor.next(action: action) { [uiState] state in

            let wasTabOnTop = uiState.rootViewController is TabBarViewController//?.items == tabAction.all
            let tabViewController = uiState.rootViewController as? TabBarViewController ?? {
                let tabController = TabBarViewController(uiStateConfig: uiState.config)
                tabController.loadViewIfNeeded()

//                tabController.items = tabAction.all
                return tabController
            }()

//            tabViewController.set(current: tabAction.tab)

            //set up current if empty (or reset)
            if let top = tabViewController.currentNavigationController, top.viewControllers.isEmpty {
                top.setViewControllers([tabAction.controllerInfo.loader.load()],
                animated: false)
            }

            if !wasTabOnTop {
                uiState.setRoot(controller: tabViewController,
                                animated: tabAction.controllerInfo.animated,
                                navigationBarHidden: tabAction.navigationBarHidden)
            }

            // dismiss modals
            uiState.rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}
