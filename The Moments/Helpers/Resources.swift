//
//  Resources.swift
//  The Moments
//
//  Created by Никита on 15.02.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static var blue = UIColor(hexString: "4E8AFE")
        static var lightBlue = UIColor(hexString: "7FA1E3")
        static var grey = UIColor(hexString: "ECECEC")
        static var black = UIColor(hexString: "777777")
    }
    
    enum TabBarResources {
        enum TabBarItemsImages {
            static var favorits = UIImage(systemName: "star")
            static var search = UIImage(systemName: "magnifyingglass")
            static var account = UIImage(systemName: "person")
        }
        
        enum TabBarItemsStrings {
            static var favorits = "Favorits"
            static var search = "Search"
            static var account = "Account"
        }
    }
    
    enum AppImageStrings {
        static var logoImage = "momentsLogo.png"
    }
    
    enum NetworkServicesStrings {
        static var baseURL = "https://mssemenov.ru"
        static var logInURL = "/api/v1/login"
        static var registerURL = "/api/v1/registration"
    }
    
    enum ErrorMessages {
        static var serverError = "Server error"
    }
    
    enum KeyChainStrings {
        static var loginService = "LoginService"
        static var loginAccount = "User"
    }
    
    enum UserDefaultsStrings {
        static var logged = "logged"
    }
}
