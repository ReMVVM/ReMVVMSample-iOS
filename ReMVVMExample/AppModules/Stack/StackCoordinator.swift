//
//  StackCoordinator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt

class StackCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowTestStackActionHandler()
        ]
    }

    private let store: Store<EXApplicationState>

    init(store: Store<EXApplicationState>) {
        self.store = store
    }

}
