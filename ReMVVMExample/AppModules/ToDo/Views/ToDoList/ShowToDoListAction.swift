//  
//  ShowToDoListAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVMCore
import ReMVVMExt

enum ToDoList: Storyboard, HasInitialController { }

struct ShowToDoListActionHandler: ConvertMiddleware {
    
    func onNext(for state: ApplicationState, action: ShowToDoListAction, dispatcher: Dispatcher) {
        let factory = CompositeViewModelFactory()
        let action = Show(on: EXNavigationTab.todo, loader: ToDoList.initialViewController, factory: factory)
        dispatcher.dispatch(action: action)
    }
}
