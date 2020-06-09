//
//  PopReducer.swift
//  BNCommon
//
//  Created by Grzegorz Jurzak, Daniel Plachta, Dariusz Grzeszczak.
//  Copyright © 2019. All rights reserved.
//

import ReMVVM

public struct PopReducer: Reducer {

    public typealias Action = Pop

    public static func reduce(state: NavigationRoot, with action: Pop) -> NavigationRoot {
        return updateStateTree(state, for: action.mode)
    }

    private static func updateStateTree(_ stateTree: NavigationRoot, for mode: PopMode) -> NavigationRoot {
        switch mode {
        case .popToRoot:
            return popStateTree(stateTree, dropCount: stateTree.topStack.count - 1)
        case .pop(let count):
            return popStateTree(stateTree, dropCount: count)
        }
    }

    private static func popStateTree(_ root: NavigationRoot, dropCount: Int) -> NavigationRoot {
        //TODO ??? czy na pewno top stack ? nie powinien pop robic dissmiss modala ?
        guard dropCount > 0, root.topStack.count > dropCount else { return root }
        let tree: NavigationTree
        let modals: [NavigationRoot.Modal]
        let newTopStack = Array(root.topStack.dropLast(dropCount))
        if root.modals.isEmpty { //no modal
            let current = root.tree.current
            var stacks = root.tree.stacks
            if let index = stacks.firstIndex(where: { $0.0 == current }) {
                stacks[index] = (current, newTopStack)
            }

            tree = NavigationTree(current: current, stacks: stacks)
            modals = root.modals
        } else { // modal
            tree = root.tree
            modals = Array(root.modals.dropLast()) + [.navigation(newTopStack)]
        }

        return NavigationRoot(tree: tree, modals: modals)
    }

}

public struct PopMiddleware: AnyMiddleware {

    public let uiState: UIState

    public init(uiState: UIState) {
        self.uiState = uiState
    }

    public func onNext<State>(for state: State,
                            action: StoreAction,
                            interceptor: Interceptor<StoreAction, State>,
                            dispatcher: Dispatcher) where State: StoreState {

        guard let state = state as? NavigationTreeContainingState, let action = action as? Pop else {
            interceptor.next()
            return
        }

        guard state.navigationTree.topStack.count > 1 else { return }

        interceptor.next { _ in
            // side effect

            switch action.mode {
            case .popToRoot:
                self.uiState.navigationController?.popToRootViewController(animated: action.animated)
            case .pop(let count):
                if count > 1 {
                    let viewControllers = self.uiState.navigationController?.viewControllers ?? []
                    let dropCount = min(count, viewControllers.count - 1) - 1
                    let newViewControllers = Array(viewControllers.dropLast(dropCount))
                    self.uiState.navigationController?.setViewControllers(newViewControllers, animated: false)
                }

                self.uiState.navigationController?.popViewController(animated: action.animated)
            }

        }

    }

}
