//
//  UserStateReducer.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore

enum UserStateReducers: Reducer {

    static let reducers = SetUserReducer.self

    static func reduce(state: UserState, with action: StoreAction) -> UserState {
        return reducers.reduce(state: state, with: action)
    }
}

enum SetUserReducer: Reducer {

    typealias Action = EXStoreActions.User.SetUserAction

    static func reduce(state: UserState, with action: Action) -> UserState {
        return UserState(user: action.user)
    }

}
