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

public enum EXNavigationTab: String, CaseIterable, NavigationTab {
    public var action: StoreAction {
        switch self {
        case .profile: return ShowProfileAction()
        case .stack: return ShowTestStackAction.showOnTab
        case .todo: return ShowToDoListAction()
        }
    }

    case todo = "TO-DO"
    case profile = "Profile"
    case stack = "Stack"

    public var title: String {
        return self.rawValue
    }

    public var iconImageName: String {
        switch self {
        case .todo:
            return "list"
        case .stack:
            return "transfer"
        case .profile:
            return "user"
        }
    }

    public var iconImageNameActive: String {
        return iconImageName
    }

    public var iconImage: Data {
        return UIImage(named: iconImageName)?.pngData() ?? Data()
    }

    public var iconImageActive: Data {
        return UIImage(named: iconImageNameActive)?.pngData() ?? Data()
    }
}
