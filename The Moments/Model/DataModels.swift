//
//  DataModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class BaseUserDataFromServer {
    var id: String?
    var name, email: String?
}

class LogInUserDataFromServer: BaseUserDataFromServer {
    var avatar, token: String?
}

class MethodArguments {
    struct AuthUserArguments {
        var login = ""
        var email = ""
        var password = ""
    }
}
