//  
//  ProfileViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore
import RxSwift

struct ProfileViewModel: Initializable {

    @ReMVVM.State private var userState: UserState?
    @ReMVVM.Dispatcher private var dispatcher

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

    private let state: Observable<UserState>

    private let disposeBag = DisposeBag()

    init() {
        state = _userState.rx.state
        logoutSubject.asObservable()
            .map { EXStoreActions.User.SetUserAction(user: nil) }
            .bind(to: _dispatcher.rx)
            .disposed(by: disposeBag)
    }

}
