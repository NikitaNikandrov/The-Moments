//
//  LoginVCPresenter.swift
//  The Moments
//
//  Created by Никита on 31.12.2021.
//

import Foundation

class LoginPresenter {
    func responseAuthHandling(response: LogInUserDataFromServer) {
        response.id = MainData.shared.id
        response.name = MainData.shared.name
        response.avatar = MainData.shared.avatar
        response.apiToken = MainData.shared.apiToken
    }
}
