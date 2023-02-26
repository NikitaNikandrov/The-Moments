//
//  Resources.swift
//  The Moments
//
//  Created by Никита on 15.02.2023.
//

import UIKit

enum Resources {
    //MARK: Colors
    enum Colors {
        static var blue = UIColor(hexString: "4E8AFE")
        static var lightBlue = UIColor(hexString: "7FA1E3")
        static var grey = UIColor(hexString: "ECECEC")
        static var black = UIColor(hexString: "777777")
    }
    
    //MARK: Tabbar resources
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
    
    //MARK: Images
    enum AppImageStrings {
        static var logoImage = "momentsLogo.png"
    }
    
    //MARK: network resources
    enum NetworkServicesStrings {
        static var baseURL = "https://mssemenov.ru"
        static var logInURL = "/api/v1/login"
        static var registerURL = "/api/v1/registration"
        static var meetingsURL = "/api/v1/meetings"
    }
    
    enum ErrorMessages {
        static var serverError = "Server error"
    }
    
    //MARK: Data service resources
    enum KeyChainStrings {
        static var loginService = "LoginService"
        static var loginAccount = "User"
    }
    
    enum UserDefaultsStrings {
        static var logged = "logged"
    }
    
    //MARK: View controllers resources
    enum LogInVCStrings {
        static var logoLabelString = "The Moments"
        static var emailTextfieldString = "Email"
        static var passwordTextfieldString = "Password"
        static var logInButtonString = "Log In"
        static var noAccountString = "Don't have an account yet ?"
        static var signUpButtonString = "Sign Up"
    }
    
    enum RegisterVCStrings {
        static var createLabelString = "Create an account"
        static var nameTextFieldString = "Name"
        static var emailTextfieldString = "Email"
        static var passwordTextfieldString = "Password"
        static var confirmPasswordTextfieldString = "Confirm password"
    }
}
