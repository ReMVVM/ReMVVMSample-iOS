//  
//  ShowToDoItemAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVM
import ReMVVMExt

enum ToDoItem: Storyboard, HasInitialController { }

struct ShowToDoItemAction: StoreAction { }

struct ShowToDoItemActionHandler: ConvertActionMiddleware {

    func convert(action: ShowToDoItemAction, state: EXApplicationState) -> Push {
        let factory = CompositeViewModelFactory()
        return Push(loader: ToDoItem.initialViewController, factory: factory)
    }

}
