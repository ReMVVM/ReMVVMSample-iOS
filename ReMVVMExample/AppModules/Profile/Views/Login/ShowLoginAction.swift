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
import EXCommon

enum Login: Storyboard, HasInitialController { }

struct ShowLoginActionHandler: ConvertActionMiddleware {

	func convert(action: ShowLoginAction, state: ApplicationState) -> ShowModal {
        let factory = CompositeViewModelFactory()
        return ShowModal(loader: Login.initialViewController, factory: factory, presentationStyle: .formSheet)
    }

}
