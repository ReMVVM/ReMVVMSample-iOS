//  
//  LoginViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore
import ReMVVMExt
import RxSwift

enum LoginResult {
    case success
    case error(String)
}

struct LoginViewModel: Initializable {

    @ReMVVM.State private var state: UserState?
    @ReMVVM.Dispatcher private var dispatcher

    var result: Observable<LoginResult>

    let title = Observable.just("LOGIN")
    let buttonTitle = Observable.just("TRY LOGIN")
    let usernameLabel = Observable.just("Username")
    let passwordLabel = Observable.just("Password (correct == Test12345)")

    let username = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let loginSubject = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    init() {

        let loginQuery = Observable
            .combineLatest(username.asObservable(), password.asObservable())
            .map { LoginQuery(username: $0.0, password: $0.1) }

        let queryResult = loginSubject.asObservable()
            .withLatestFrom(loginQuery)
            .map { $0.tryLogin() }
            .share()

        self.result = queryResult
            .map { queryResult -> LoginResult in
                guard let error = queryResult.error else { return .success }
                return .error(error)
            }

        queryResult.compactMap { $0.user }
            .map { EXStoreActions.User.SetUserAction(user: $0) }
            .bind(to: _dispatcher.rx)
            .disposed(by: disposeBag)

    }

}
