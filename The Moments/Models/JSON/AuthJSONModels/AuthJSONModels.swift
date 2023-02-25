//
//  LogInJSONModel.swift
//  The Moments
//
//  Created by Никита on 19.02.2023.
//

import Foundation

class AuthJSONModel {

    struct SuccessAuthJSONmodel: Codable {
        let code: Int
        let success: Bool
        let data: DataLogInJSONModel
    }

    struct DataLogInJSONModel: Codable {
        let id: Int
            let name, email: String
            let firstName, lastName, middleName, phone: String?
            let dateBirth: String?
            let token: String
            let avatar: Avatar?

            enum CodingKeys: String, CodingKey {
                case id, name, email
                case firstName = "first_name"
                case lastName = "last_name"
                case middleName = "middle_name"
                case phone
                case dateBirth = "date_birth"
                case token, avatar
            }
    }
    
    struct Avatar: Codable {
        let id: Int
        let image: String
        let size: Int?
        let preview: [Avatar]?
    }
    
    
    struct BadPassRegistrJSONModel: Codable {
        let code: Int
        let success: Bool
        let message: BadPassRegistrMessage
    }
    
    struct BadPassRegistrMessage: Codable {
        let password: [String]
    }
    
    struct FailRegisterRegistrJSONModel: Codable {
        let code: Int
        let success: Bool
        let message: String
    }
}
