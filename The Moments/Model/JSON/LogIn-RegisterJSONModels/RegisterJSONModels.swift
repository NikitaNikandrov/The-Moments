//
//  JSONModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class RegisterJSONModels {

    struct SuccessRegistrJSONModel: Codable {
        let code: Int
        let success: Bool
        let data: DataRegistrJSON
    }

    struct DataRegistrJSON: Codable {
        let id: Int
        let name, email: String
        let firstName, lastName, middleName, phone: JSONNull?
        let dateBirth: JSONNull?
        let token: String
        let avatar: JSONNull?

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
