//
//  UserStateReducer.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM

public enum UserStateReducers {

    static func reduce(state: UserState, with action: StoreAction) -> UserState {
        return reducer.reduce(state: state, with: action)
    }

    static let reducer = AnyReducer(with: reducers)
    static let reducers: [AnyReducer<UserState>] = [
        SetUserReducer.any
    ]

}

struct SetUserReducer: Reducer {

    typealias Action = EXStoreActions.User.SetUserAction

    static func reduce(state: UserState, with action: Action) -> UserState {
        return UserState(user: action.user)
    }

}
