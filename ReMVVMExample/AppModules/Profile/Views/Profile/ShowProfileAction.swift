//  
//  ShowProfileAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVMCore
import ReMVVMExt

enum Profile: Storyboard, HasInitialController { }

struct ShowProfileActionHandler: ConvertMiddleware {

    func onNext(for state: ApplicationState, action: ShowProfileAction, dispatcher: Dispatcher) {
        let factory = CompositeViewModelFactory()
        let action = Show(on: EXNavigationTab.profile, loader: Profile.initialViewController, factory: factory)
        dispatcher.dispatch(action: action)
    }
}
