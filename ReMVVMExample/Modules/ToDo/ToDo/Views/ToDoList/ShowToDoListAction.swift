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
import EXCommon

enum ToDoList: Storyboard, HasInitialController { }

struct ShowToDoListActionHandler: ConvertActionMiddleware {

	func convert(action: ShowToDoListAction, state: ApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.todo, loader: ToDoList.initialViewController, factory: factory)
    }

}

struct ShowToDoList1ActionHandler: ConvertActionMiddleware {

    func convert(action: ShowToDoList1Action, state: ApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.todo1, loader: ToDoList.initialViewController, factory: factory)
    }

}
