//
//  DataModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class UserDataFromServer {
    var id: Int?
    var name, email, avatar, apiToken: String?
}

class MethodsArguments {
    struct RegsterRequestArguments {
        var login: String
        var password: String
        var passwordConfirm: String
    }
}
