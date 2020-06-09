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


public final class TabBarViewModel: Initializable, StateObserver, ReMVVMDriven {
    public typealias State = NavigationTreeContainingState

    public let items: Observable<[AnyNavigationTab]>
    public let selected: Observable<AnyNavigationTab>

    public init() {

        let state = TabBarViewModel.remvvm.stateSubject.rx.state

        items = state.map { $0.navigationTree.tree.stacks.map { $0.0 }}
                    .distinctUntilChanged()

        selected = state.map { $0.navigationTree.tree.current }
                    .distinctUntilChanged()
    }
}

public typealias CaseIterableNavigationTab = NavigationTab & CaseIterable

public protocol NavigationTab: /*Equatable,*/ Hashable {
    var title: String { get }
    var iconImage: Data { get }
    var iconImageActive: Data { get }
    var action: StoreAction { get }
}


public struct AnyNavigationTab: NavigationTab {

    //public static var allCases: [AnyNavigationTab] { [] }

    public let title: String
    public let iconImage: Data
    public let iconImageActive: Data
    public let action: StoreAction

    let base: Any

    public init<T: NavigationTab>(_ tab: T) {
        title = tab.title
        iconImage = tab.iconImage
        iconImageActive = tab.iconImageActive
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
