//
//  SignUpVCPresenter.swift
//  The Moments
//
//  Created by Никита on 07.01.2022.
//

import Foundation

enum PasswordState {
    case hideLabel
    case min6char
    case differentPass
    case ok
}

class RegisterPresenter {
    func passwordManager(password: String, confirmPassword: String) -> PasswordState {
        if password == "" && confirmPassword == "" {
            return .hideLabel
        }
        else if (password == "" || confirmPassword == "") && (password.count < 6 || confirmPassword.count < 6) {
            return .min6char
        }
        else if password.count >= 6 && confirmPassword.count >= 6 && (password != confirmPassword) {
            return .differentPass
        } else if password.count >= 6 && confirmPassword.count >= 6 && (password == confirmPassword) {
            return .ok
        } else {
            return .hideLabel
        }
    }
}
