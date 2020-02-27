//
//  StoreActions.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM

struct EXStoreActions {
    struct User { }
}

extension EXStoreActions.User {
    struct SetUserAction: StoreAction {
        let user: User?
        init(user: User?) {
            self.user = user
        }
    }
}
