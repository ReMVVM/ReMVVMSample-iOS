//
//  EXApplicationState.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 22/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt

struct EXApplicationState: NavigationTreeContainingState, NavigationTabState {

    static let empty = EXApplicationState()

    static var allTabs: [AnyNavigationTab] = [
        EXNavigationTab.stack.any,
        EXNavigationTab.todo.any,
        EXNavigationTab.profile.any
    ]

    var factory: ViewModelFactory {
        if navigationTree.factory is CompositeViewModelFactory {
            return navigationTree.factory
        } else {
            return CompositeViewModelFactory(with: navigationTree.factory)
        }
    }
    
    let navigationTree: NavigationTree
    let currentTab: AnyNavigationTab?
    let userState: UserState

    init(navigationTree: NavigationTree = NavigationTree(stack: [], modals: []),
         currentTab: AnyNavigationTab? = nil,
         userState: UserState = .empty) {

        self.navigationTree = navigationTree
        self.currentTab = currentTab
        self.userState = userState
    }
}

struct UserState {
    public let user: User?

    public var isLoggedIn: Bool { return user != nil }

    public static let empty = UserState(user: nil)

    public init(user: User?) {
        self.user = user
    }
}
