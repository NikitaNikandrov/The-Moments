//
//  DataModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class UserDataModel {
    var id: Int?
    var name: String?
    var email: String?
}

class LogInUserDataFromServer: UserDataModel {
    var token: String?
}
