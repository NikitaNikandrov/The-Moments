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
                guard let resultToken = result.token else { return }
                
                guard let dataToken = resultToken.data(using: .utf8) else { return }
                do {
                    try KeyChainManager.save(password: dataToken,
                                             service: Resources.KeyChainStrings.loginService,
                                             account: Resources.KeyChainStrings.loginAccount)
                } catch { print("keychain save error") }
                
                UserDefaults.standard.set(true, forKey: Resources.UserDefaultsStrings.logged)
                
                self?.loginResult.value = StatusConditions.succes
                
            case let .error(code, message):
                self?.errorMessage.value = "Code " + String(code) + ": " + message
                self?.loginResult.value = StatusConditions.fail
            }
        }
    }
}
