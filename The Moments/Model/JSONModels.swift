//
//  JSONModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class JSONModels {
    struct UserDataFromServer: Codable {
        let id: Int
        let name, email, avatar, apiToken: String

        enum CodingKeys: String, CodingKey {
            case id, name, email, avatar
            case apiToken = "api_token"
        }
    }

}
