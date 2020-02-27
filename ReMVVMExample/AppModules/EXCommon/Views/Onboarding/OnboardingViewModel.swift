//  
//  OnboardingViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 24/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import RxSwift

struct OnboardingViewModel: Initializable, StateAssociated, ReMVVMDriven {

    typealias State = UserState

    let title = Observable.just("Onboarding")
    let homeTitle = Observable.just("Home")
    let loginTitle = Observable.just("Login")

    var isLoggedIn: Observable<Bool> { return state.map { $0.isLoggedIn } }

    private let state = remvvm.stateSubject.rx.state

    init() { }

}
