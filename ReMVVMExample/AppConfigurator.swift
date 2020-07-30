//
//  AppConfigurator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 23/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import UIKit
import EXCommon
import ToDo

struct AppConfigurator {
    static var window: UIWindow?
    static var store: Dispatcher?
    static var wireframes: [Any]?

    static func allMiddleware() -> [AnyMiddleware] {
        return CommonCoordinator.createMiddlewares()
            + ProfileCoordinator.createMiddlewares()
            + StackCoordinator.createMiddlewares()
            + ToDoCoordinator.createMiddlewares()
    }

    @discardableResult static func setupAplication(with state: ApplicationState = .empty) -> Dispatcher & Subject {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let dispatcher = EXUIApplication.initialize(with: window,
                                               middlewares: AppConfigurator.allMiddleware(),
                                               state: state)

        window.makeKeyAndVisible()
        AppConfigurator.window = window
        AppConfigurator.store = store

        wireframes = [
            CommonCoordinator(dispatcher: dispatcher),
            ProfileCoordinator(dispatcher: dispatcher),
            StackCoordinator(dispatcher: dispatcher),
            ToDoCoordinator(dispatcher: dispatcher)
        ]

        return dispatcher
    }
}
