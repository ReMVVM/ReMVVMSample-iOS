//  
//  ShowOnboardingAction.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 24/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Loaders
import ReMVVMCore
import ReMVVMExt

enum Onboarding: Storyboard, HasInitialController { }

public struct ShowOnboardingAction: StoreAction {
    public init() { }
}

struct ShowOnboardingActionHandler: Middleware {


    func onNext(for state: ApplicationState,
                action: ShowOnboardingAction,
                interceptor: Interceptor<ShowOnboardingAction, ApplicationState>,
                dispatcher: Dispatcher) {

        let factory = CompositeViewModelFactory()

        //factory.add { TabBarViewModel() }

//        let tabItemCreator = { () -> UIView in
//            return EXTabItemView()
//        }

//        let showOnTab = ShowOnTab(tab: EXNavigationTab.stack,
//                                  loader: Onboarding.initialViewController,
//                                  tabItemCreator: tabItemCreator,
//                                  factory: factory)

        let showOnRoot = ShowOnRoot(loader: Onboarding.initialViewController,
                                    factory: factory,
                                    navigationBarHidden: false)
        dispatcher.dispatch(action: showOnRoot)

    }


//    func convert(action: ShowOnboardingAction, state: EXApplicationState) -> ShowOnTab {
//        let factory = CompositeViewModelFactory()
//        return ShowOnTab(tab: EXNavigationTab.home, loader: Onboarding.initialViewController, factory: factory)
//        //return ShowOnRoot(loader: Onboarding.initialViewController, factory: factory)
//    }

//    func convert(action: ShowOnboardingAction, state: EXApplicationState) -> ShowModal {
//        let factory = CompositeViewModelFactory()
//        return ShowModal(loader: Onboarding.initialViewController, factory: factory)
////        return ShowOnRoot(loader: Onboarding.initialViewController, factory: factory)
//    }

}
