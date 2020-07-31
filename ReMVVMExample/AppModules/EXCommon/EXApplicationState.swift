//
//  EXApplicationState.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 22/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt

// probably not needed anymoore as far there is no need foor custom nav 
//public typealias EXApplicationState = NavigationStateIOS<ApplicationState>

public struct ApplicationState {

    public static let empty = ApplicationState()

    public let userState: UserState

    public init(userState: UserState = .empty) {

        self.userState = userState
    }
}

public struct UserState {
    public let user: User?

    public var isLoggedIn: Bool { return user != nil }

    public static let empty = UserState(user: nil)

    public init(user: User?) {
        self.user = user
    }
}
