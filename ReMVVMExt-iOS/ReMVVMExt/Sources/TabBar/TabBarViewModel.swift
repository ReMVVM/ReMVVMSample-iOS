//
//  TabBarViewModel.swift
//  BNCommon
//
//  Created by Grzegorz Jurzak on 12/02/2019.
//  Copyright © 2019 HYD. All rights reserved.
//

import Foundation
import ReMVVM
import RxSwift


open class TabBarViewModel<Tab: NavigationTab>: Initializable, StateObserver, ReMVVMDriven {
    public typealias State = NavigationTreeContainingState

    public let items: Observable<[Tab]>
    public let selected: Observable<Tab>

    required public init() {

        let state = TabBarViewModel.remvvm.stateSubject.rx.state
        if Tab.self == AnyNavigationTab.self {
            let tabType = state.map { type(of: $0.navigationTree.tree.current.base) }.take(1).share()
            items = state.map { $0.navigationTree.tree.stacks.map { $0.0 }}
                        .withLatestFrom(tabType) { items, tabType -> [Tab] in
                            items
                                .filter { type(of: $0.base) == tabType }
                                .compactMap { $0 as? Tab }
                        }
                        .filter { $0.count != 0}
                        .distinctUntilChanged()

            selected = state.compactMap { $0.navigationTree.tree.current as? Tab }
                            .distinctUntilChanged()
        } else {
            items = state.map { $0.navigationTree.tree.stacks.compactMap { $0.0.base as? Tab }}
                        .filter { $0.count != 0}
                        .distinctUntilChanged()

            selected = state.compactMap { $0.navigationTree.tree.current.base as? Tab }
                        .distinctUntilChanged()
        }
    }
}

public typealias CaseIterableNavigationTab = NavigationTab & CaseIterable

public protocol NavigationTab: Hashable {
    var action: StoreAction { get }
}

public struct AnyNavigationTab: NavigationTab {

    public let action: StoreAction

    let base: Any

    public init<T: NavigationTab>(_ tab: T) {

        action = tab.action

        base = tab

        isEqual = { t in
            guard let t = t.base as? T else { return false }
            return tab == t
        }

        _hash = { hasher in
            tab.hash(into: &hasher)
        }
    }

    public func hash(into hasher: inout Hasher) {
        _hash(&hasher)
    }

    private var isEqual: (AnyNavigationTab) -> Bool
    private var _hash: (inout Hasher) -> Void

    public static func == (lhs: AnyNavigationTab, rhs: AnyNavigationTab) -> Bool {
        lhs.isEqual(rhs)
    }

}

extension NavigationTab {

    public var any: AnyNavigationTab {
        return AnyNavigationTab(self)
    }
}

extension Collection where Element: NavigationTab {
    public var any: [AnyNavigationTab] {
        return map { $0.any }
    }
}
