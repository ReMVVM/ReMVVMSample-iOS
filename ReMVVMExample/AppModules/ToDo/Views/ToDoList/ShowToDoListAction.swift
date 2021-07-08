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

struct ShowToDoListActionHandler: ConvertActionMiddleware {

	func convert(action: ShowToDoListAction, state: ApplicationState) -> Show {
        let factory = CompositeViewModelFactory()
        return Show(on: EXNavigationTab.todo, loader: ToDoList.initialViewController, factory: factory)
    }

}
