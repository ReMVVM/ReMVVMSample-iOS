//  
//  ShowTestStackAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVM
import ReMVVMExt

enum TestStack: Storyboard, HasInitialController { }

struct ShowTestStackActionHandler: Middleware {

    func onNext(for state: ApplicationState,
                action: ShowTestStackAction,
                interceptor: Interceptor<ShowTestStackAction, ApplicationState>,
                dispatcher: Dispatcher) {

        let loader = TestStack.initialViewController
        var storeAction: StoreAction

        switch action {
        case .showModal:
            let factory = CompositeViewModelFactory { TestStackViewModel(isOnModal: true) }
            storeAction = ShowModal(loader: loader, factory: factory)
        case .showOnTab:
            let factory = CompositeViewModelFactory { TestStackViewModel(isOnModal: false) }
            storeAction = Show(on: EXNavigationTab.stack,
                                    loader: loader,
                                    factory: factory)
        case .push:
            let factory = CompositeViewModelFactory { TestStackViewModel(isOnModal: false) }
            storeAction = Push(loader: loader, factory: factory)
        }

        dispatcher.dispatch(action: storeAction)
    }

}
