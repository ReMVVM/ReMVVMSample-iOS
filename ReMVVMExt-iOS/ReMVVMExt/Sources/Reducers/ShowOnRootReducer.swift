//
//  ShowOnRootReducer.swift
//  BNCommon
//
//  Created by Grzegorz Jurzak, Daniel Plachta, Dariusz Grzeszczak.
//  Copyright © 2019. All rights reserved.
//

import ReMVVM

struct ShowOnRootReducer: Reducer {

    public static func reduce(state: NavigationRoot, with action: ShowOnRoot) -> NavigationRoot {

        let current = NavigationTree.Root.flat
        let stacks = [(current, [action.controllerInfo.factory])]
        let tree = NavigationTree(current: current, stacks: stacks)
        return NavigationRoot(tree: tree, modals: [])
    }
}

public struct ShowOnRootMiddleware: AnyMiddleware {

    public let uiState: UIState

    public init(uiState: UIState) {
        self.uiState = uiState
    }

    public func onNext<State>(for state: State,
                            action: StoreAction,
                            interceptor: Interceptor<StoreAction, State>,
                            dispatcher: Dispatcher) where State: StoreState {

        guard state is NavigationTreeContainingState, let action = action as? ShowOnRoot else {
            interceptor.next()
            return
        }

        let uiState = self.uiState

        interceptor.next { _ in // newState - state variable is used below
            // side effect

            uiState.setRoot(controller: action.controllerInfo.loader.load(),
                            animated: action.controllerInfo.animated,
                            navigationBarHidden: action.navigationBarHidden)

            // dismiss modals
            uiState.rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}
