//
//  AppConfigurator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 23/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import UIKit

struct AppConfigurator {
    static var window: UIWindow?
    static var store: Store<EXApplicationState>?
    static var wireframes: [Any]?

    static func allMiddleware() -> [AnyMiddleware] {
        return CommonCoordinator.createMiddlewares()
            + ProfileCoordinator.createMiddlewares()
            + StackCoordinator.createMiddlewares()
            + ToDoCoordinator.createMiddlewares()
    }

    @discardableResult static func setupAplication(with state: EXApplicationState = .empty) -> Store<EXApplicationState> {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let store = EXUIApplication.initialize(with: window,
                                               middlewares: AppConfigurator.allMiddleware(),
                                               state: state)

        window.makeKeyAndVisible()
        AppConfigurator.window = window
        AppConfigurator.store = store


        //let aa = Package()

        wireframes = [
            CommonCoordinator(store: store),
            ProfileCoordinator(store: store),
            StackCoordinator(store: store),
            ToDoCoordinator(store: store)
        ]

        return store
    }
}
