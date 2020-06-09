//  
//  ShowProfileAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVM
import ReMVVMExt

enum Profile: Storyboard, HasInitialController { }

struct ShowProfileAction: StoreAction { }

struct ShowProfileActionHandler: ConvertActionMiddleware {

	func convert(action: ShowProfileAction, state: EXApplicationState) -> ShowOnTab {
        let factory = CompositeViewModelFactory()
        return ShowOnTab(tab: EXNavigationTab.profile, loader: Profile.initialViewController, factory: factory)
    }

}

struct ShowProfileAction1: StoreAction { }

struct ShowProfile1ActionHandler: ConvertActionMiddleware {

    func convert(action: ShowProfileAction1, state: EXApplicationState) -> ShowOnTab {
        let factory = CompositeViewModelFactory()
        return ShowOnTab(tab: EXNavigationTab.profile1, loader: Profile.initialViewController, factory: factory)
    }

}
