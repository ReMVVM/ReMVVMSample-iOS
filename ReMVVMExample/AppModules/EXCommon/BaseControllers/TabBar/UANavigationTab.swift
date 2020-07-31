//
//  EXNavigationTab.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 24/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Foundation
import ReMVVM
import ReMVVMExt

public enum EXNavigationTab: String, CaseIterable, NavigationItem {

    case todo = "TO-DO"
    case profile = "Profile"
    case stack = "Stack"

    public var action: StoreAction {
        switch self {
        case .profile: return ShowProfileAction()
        case .stack: return ShowTestStackAction.showOnTab
        case .todo: return ShowToDoListAction()
        }
    }
}
