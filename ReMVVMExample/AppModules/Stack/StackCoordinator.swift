//
//  StackCoordinator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore
import ReMVVMExt

class StackCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowTestStackActionHandler()
        ]
    }

    private let dispatcher: Dispatcher

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }

}
