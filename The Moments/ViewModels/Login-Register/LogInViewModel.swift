//
//  LogInViewModel.swift
//  The Moments
//
//  Created by Никита on 19.02.2023.
//

import Foundation

class LogInViewModel {
    
    var loginResult = Bindable<StatusConditions>(StatusConditions.unknowned)
    var errorMessage = Bindable<String>("")
    
    func logInButtonIsPressed(login: String, password: String) {
        let requestService = AuthenticationRequestService()
        requestService.logInRequest(login: login, password: password) { [weak self] result in
            switch result {
            case let .sucsess(result):
                self?.loginResult.value = StatusConditions.succes
            case let .error(code, message):
                self?.errorMessage.value = message
                self?.loginResult.value = StatusConditions.fail
            }
        }
    }
}
