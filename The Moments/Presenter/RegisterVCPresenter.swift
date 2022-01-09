//
//  SignUpVCPresenter.swift
//  The Moments
//
//  Created by Никита on 07.01.2022.
//

import Foundation

class RegisterPresenter {
    func comparePassword(password: String, confirmPassword: String) -> Bool {
        if password == confirmPassword {
            return true
        }
        else {
            return false
        }
    }
}
