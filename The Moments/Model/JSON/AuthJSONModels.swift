//
//  JSONModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class LoginJSONModels {

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

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
