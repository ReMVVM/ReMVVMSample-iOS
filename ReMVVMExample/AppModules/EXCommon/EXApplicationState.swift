//
//  EXApplicationState.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 22/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore
import ReMVVMExt

// probably not needed anymoore as far there is no need foor custom nav 
//public typealias EXApplicationState = NavigationStateIOS<ApplicationState>

struct ApplicationState {

    static let empty = ApplicationState()

    let userState: UserState

    init(userState: UserState = .empty) {

        self.userState = userState
    }
}

struct UserState {
    let user: User?

    var isLoggedIn: Bool { return user != nil }

    static let empty = UserState(user: nil)

    init(user: User?) {
        self.user = user
    }
}
