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

public enum EXNavigationTab: String, CaseIterableNavigationTab {
    public var action: StoreAction {
        switch self {
        case .profile: return ShowProfileAction()
        case .stack: return ShowTestStackAction.showOnTab
        case .todo: return ShowToDoListAction()

        case .profile1: return ShowProfileAction1()
        case .stack1: return ShowTestStackAction.showOnTab//ShowOnTab(tab: EXNavigationTab.stack1,
            //loader: TestStack.initialViewController,
            //factory: CompositeViewModelFactory())
        case .todo1: return ShowToDoList1Action()
        }
    }

    case todo = "TO-DO"
    case profile = "Profile"
    case stack = "Stack"

    case profile1 = "Profile1"
    case stack1 = "Stack1"
    case todo1 = "TO-DO1"

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
            case .todo1:
                return "list"
            case .stack1:
                return "transfer"
            case .profile1:
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
