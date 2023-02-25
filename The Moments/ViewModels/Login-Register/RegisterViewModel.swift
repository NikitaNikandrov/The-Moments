//
//  RegisterViewModel.swift
//  The Moments
//
//  Created by Никита on 25.02.2023.
//

import Foundation

class RegisterViewModel {
    var registerResult = Bindable<StatusState>(StatusState.unknowned)
    var alertMessage = Bindable<String>("")
    
    func signUpButtonIsPressed(registerArguments: MethodArguments.RegisterUserArguments) {
        let requestService = AuthenticationRequestService()
        requestService.registerRequest(registerArguments: registerArguments) { [weak self] result in
            switch result {
            case let .sucsess(result):
                self?.alertMessage.value = result.name ?? ""
                self?.registerResult.value = StatusState.succes
            case let .error(code, message):
                self?.alertMessage.value = "Code " + String(code) + ": " + message
                self?.registerResult.value = StatusState.fail
            }
        }
    }
    
    func passwordManager(password: String, confirmPassword: String) -> PasswordState {
        if password == "" && confirmPassword == "" {
            return .hideLabel
        } else if (password == "" || confirmPassword == "") && (password.count < 6 || confirmPassword.count < 6) {
            return .min6char
        } else if password.count >= 6 && confirmPassword.count >= 6 && (password != confirmPassword) {
            return .differentPass
        } else if password.count >= 6 && confirmPassword.count >= 6 && (password == confirmPassword) {
            return .ok
        } else {
            return .hideLabel
        }
    }
}
