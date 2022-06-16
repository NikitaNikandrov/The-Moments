//
//  LoginVCPresenter.swift
//  The Moments
//
//  Created by Никита on 31.12.2021.
//

import Foundation

protocol LoginVCDelegate: NSObjectProtocol {
    func presentFavoritsVC()
    func failAuthAlert(code: Int, message: String)
}

class LoginPresenter {
    
    weak var delegate: LoginVCDelegate?
    
    private func saveToken(token: String, name: String) -> Bool {
        let tag = name.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tag,
            kSecValueData as String: token,
        ]
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            return true
        } else {
            return false
        }
    }
    
    func logInButtomIsPressed(login: String, password: String) {
        let requestService = AuthRequestServices()
        requestService.logInRequest(login: login, password: password) { [weak self] result in
            switch result {
            case let .sucsess(result):
                guard let token = result.token else { return }
                guard let name = result.name else { return }
                DispatchQueue.main.async {
                    self?.saveToken(token: token, name: name)
                    self?.delegate?.presentFavoritsVC()
                }
            case let .error(code, message):
                DispatchQueue.main.async {
                    self?.delegate?.failAuthAlert(code: code, message: message)
                }
            }
        }
    }
}
