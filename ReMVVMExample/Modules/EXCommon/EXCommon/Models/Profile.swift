//
//  Profile.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import Foundation

public struct User: Codable {

    public let username: String

    public init(username: String = "jane_doe") {
        self.username = username
    }

}

public struct LoginQuery {

    private let username: String
    private let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    public func tryLogin() -> (user: User?, error: String?) {
        guard !username.isEmpty else {
            return (user: nil, error: "Username is required")
        }

        guard !password.isEmpty else {
            return (user: nil, error: "Password is required")
        }

        guard password == "Test12345" else {
            return (user: nil, error: "Wrong credentials")
        }

        return (user: User(username: username), error: nil)
    }

}
