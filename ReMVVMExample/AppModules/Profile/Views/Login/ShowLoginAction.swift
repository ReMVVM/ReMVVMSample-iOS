//  
//  ShowLoginAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVM
import ReMVVMExt

enum Login: Storyboard, HasInitialController { }

struct ShowLoginAction: StoreAction { }

struct ShowLoginActionHandler: ConvertActionMiddleware {

	func convert(action: ShowLoginAction, state: EXApplicationState) -> ShowModal {
        let factory = CompositeViewModelFactory()
        return ShowModal(loader: Login.initialViewController, factory: factory, presentationStyle: .formSheet)
    }

}
