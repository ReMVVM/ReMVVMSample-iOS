//
//  CommonCoordinator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 23/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import RxSwift

class CommonCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowOnboardingActionHandler()
        ]
    }

    private let store: Store<EXApplicationState>
    private let disposeBag = DisposeBag()

    init(store: Store<EXApplicationState>) {
        self.store = store

        // Show onboardin
        //store.dispatch(action: ShowOnboardingAction())
        store.dispatch(action: ShowTestStackAction.showOnTab)

    }

}
