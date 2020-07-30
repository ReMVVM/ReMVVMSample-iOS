//  
//  ProfileViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import RxSwift
import EXCommon

struct ProfileViewModel: Initializable, StateAssociated, ReMVVMDriven {

    typealias State = UserState

    let logoutSubject = PublishSubject<Void>()

    let title = Observable.just("Profile")

    let showOnboardingTitle = Observable.just("Show onboarding")
    let logoutTitle = Observable.just("Log out")

    var welcomeText: Observable<String> {
        return username.map { username -> String in
            guard let username = username else { return "You're not logged in." }
            return "Welcome \(username)"
        }
    }

    var isLoggedIn: Observable<Bool> { return state.map { $0.isLoggedIn } }

    private var username: Observable<String?> {
        return state.map { $0.user?.username }
    }

    private let state = remvvm.stateSubject.rx.state

    private let disposeBag = DisposeBag()

    init() {
        logoutSubject.asObservable()
            .map { EXStoreActions.User.SetUserAction(user: nil) }
            .bind(to: remvvm.rx)
            .disposed(by: disposeBag)
    }

}
