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
import EXCommon


enum Profile: Storyboard, HasInitialController { }

struct ShowProfileActionHandler: ConvertActionMiddleware {


	func convert(action: ShowProfileAction, state: ApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.profile, loader: Profile.initialViewController, factory: factory)
    }

}

struct ShowProfile1ActionHandler: ConvertActionMiddleware {

    func convert(action: ShowProfileAction1, state: ApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.profile1, loader: Profile.initialViewController, factory: factory)
    }

}
