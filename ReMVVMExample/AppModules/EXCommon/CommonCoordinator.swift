//
//  CommonCoordinator.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 23/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import RxSwift
import ReMVVMExt

public enum ShowTestStackAction: StoreAction {
    case showOnTab, showModal, push
}

public struct ShowLoginAction: StoreAction { }

public struct ShowProfileAction: StoreAction { }

public struct ShowToDoListAction: StoreAction { }

public class CommonCoordinator {

    public static func createMiddlewares() -> [AnyMiddleware] {
        return [
            ShowOnboardingActionHandler().any
        ]
    }

    private let dispatcher: Dispatcher
    private let disposeBag = DisposeBag()

    public init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher

        // Show onboardin
        //store.dispatch(action: ShowOnboardingAction())
        dispatcher.dispatch(action: ShowTestStackAction.showOnTab)

    }

}
