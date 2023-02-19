//
//  LogInJSONModel.swift
//  The Moments
//
//  Created by Никита on 19.02.2023.
//

import Foundation

class LoginJSONModel {

    struct SuccessLogInJSONmodel: Codable {
        let code: Int
        let success: Bool
        let data: DataLogInJSONModel
    }

    struct DataLogInJSONModel: Codable {
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
}
