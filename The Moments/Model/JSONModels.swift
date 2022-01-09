//
//  JSONModels.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class JSONModels {
    //Mark: Log in JSON model
    struct LogInJSONmodel: Codable {
        let message: String?
        let data: LogInJSONdataModel?
    }
    struct LogInJSONdataModel: Codable {
        let id: Int
        let name, email: String
        let avatar: String
        let apiToken: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, email, avatar
            case apiToken = "api_token"
        }
    }
    
    //Mark: another models
}
