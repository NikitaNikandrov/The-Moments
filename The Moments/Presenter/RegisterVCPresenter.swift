//
//  SignUpVCPresenter.swift
//  The Moments
//
//  Created by Никита on 07.01.2022.
//

import Foundation

class RegisterPresenter {
    func passwordManager(password: String, confirmPassword: String) -> Int {
        if password == "" && confirmPassword == "" {
            return 0
        }
        else if (password == "" || confirmPassword == "") && (password.count < 6 || confirmPassword.count < 6) {
            return 1
        }
        else if password.count >= 6 && confirmPassword.count >= 6 && (password != confirmPassword) {
            return 2
        } else if password.count >= 6 && confirmPassword.count >= 6 && (password == confirmPassword) {
            return 3
        } else {
            return 0
        }
        /* Mark:
         0 - hide label
         1 - min 6 char
         2 - length pass is ok, but passes are different
         3 - ok
         */
    }
}
