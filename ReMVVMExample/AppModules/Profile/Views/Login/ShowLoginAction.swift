//  
//  ShowLoginAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVMCore
import ReMVVMExt

enum Login: Storyboard, HasInitialController { }

struct ShowLoginActionHandler: ConvertMiddleware {

    func onNext(for state: ApplicationState, action: ShowLoginAction, dispatcher: Dispatcher) {
        let factory = CompositeViewModelFactory()
        let action = ShowModal(loader: Login.initialViewController, factory: factory, presentationStyle: .formSheet)
        dispatcher.dispatch(action: action)
    }
}
