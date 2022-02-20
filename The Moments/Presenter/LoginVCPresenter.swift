//
//  LoginVCPresenter.swift
//  The Moments
//
//  Created by Никита on 31.12.2021.
//

import Foundation

class LoginPresenter {
    func responseAuthHandling(response: LogInUserDataFromServer) {
        response.id = PersonData.shared.id
        response.name = PersonData.shared.name
        response.avatar = PersonData.shared.avatar
        response.apiToken = PersonData.shared.apiToken
    }
}
