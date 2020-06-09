//
//  EXApplicationState.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 22/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt

typealias EXApplicationState = ReMVVMiOSState<ApplicationState>

struct ApplicationState {

    static let empty = ApplicationState()

    let userState: UserState

    init(userState: UserState = .empty) {

        self.userState = userState
    }
}

struct UserState {
    public let user: User?

    public var isLoggedIn: Bool { return user != nil }

    public static let empty = UserState(user: nil)

    public init(user: User?) {
        self.user = user
    }
}
