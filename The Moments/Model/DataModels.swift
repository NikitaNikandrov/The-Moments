//
//  DataModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class BaseUserDataFromServer {
    var id: Int?
    var name, email: String?
}

class LogInUserDataFromServer: BaseUserDataFromServer {
    var avatar, apiToken: String?
}

class MethodArguments {
    struct AuthUserArguments {
        var login = ""
        var password = ""
        var confirmPassword = ""
    }
}
