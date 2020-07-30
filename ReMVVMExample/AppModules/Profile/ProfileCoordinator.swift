//
//  ProfileCoordinator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt
import RxSwift
import EXCommon

class ProfileCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowLoginActionHandler().any,
            ShowProfileActionHandler().any,
            ShowProfile1ActionHandler().any
        ]
    }

    private let dispatcher: Dispatcher
    private let disposeBag = DisposeBag()

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }

}
