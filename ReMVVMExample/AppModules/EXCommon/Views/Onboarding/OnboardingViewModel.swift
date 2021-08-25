//  
//  OnboardingViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 24/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore
import RxSwift

struct OnboardingViewModel: Initializable {

    @ReMVVM.State private var userState: UserState?

    let title = Observable.just("Onboarding")
    let homeTitle = Observable.just("Home")
    let loginTitle = Observable.just("Login")

    var isLoggedIn: Observable<Bool> { return _userState.rx.state.map { $0.isLoggedIn } }

    init() { }

}
