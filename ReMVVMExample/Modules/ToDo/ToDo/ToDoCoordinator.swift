//
//  ToDoCoordinator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt
import EXCommon

public class ToDoCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowToDoListActionHandler().any,
            ShowToDoList1ActionHandler().any,
            ShowToDoItemActionHandler().any
        ]
    }

    private let dispatcher: Dispatcher

    public init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }

}
