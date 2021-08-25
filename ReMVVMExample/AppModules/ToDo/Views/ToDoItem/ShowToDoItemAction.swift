//  
//  ShowToDoItemAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVMCore
import ReMVVMExt

enum ToDoItem: Storyboard, HasInitialController { }

struct ShowToDoItemAction: StoreAction { }

struct ShowToDoItemActionHandler: ConvertMiddleware {

    func onNext(for state: ApplicationState, action: ShowToDoItemAction, dispatcher: Dispatcher) {
        let factory = CompositeViewModelFactory()
        let action = Push(loader: ToDoItem.initialViewController, factory: factory)
        dispatcher.dispatch(action: action)
    }
}
