//  
//  ShowToDoListAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVM
import ReMVVMExt

enum ToDoList: Storyboard, HasInitialController { }

struct ShowToDoListAction: StoreAction { }

struct ShowToDoListActionHandler: ConvertActionMiddleware {

	func convert(action: ShowToDoListAction, state: EXApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.todo, loader: ToDoList.initialViewController, factory: factory)
    }

}

struct ShowToDoList1Action: StoreAction { }

struct ShowToDoList1ActionHandler: ConvertActionMiddleware {

    func convert(action: ShowToDoList1Action, state: EXApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.todo1, loader: ToDoList.initialViewController, factory: factory)
    }

}
