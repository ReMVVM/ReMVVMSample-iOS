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

class ProfileCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowLoginActionHandler(),
            ShowProfileActionHandler()
        ]
    }

    private let store: Store<EXApplicationState>
    private let disposeBag = DisposeBag()

    init(store: Store<EXApplicationState>) {
        self.store = store
    }

}
