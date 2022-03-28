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
    
    //MeetingsList JSON model
    struct MeetingsListJSONModel: Codable {
        let id: Int
        let name, description: String
        let owner: Owner
        let startAt, endAt, createdAt, updatedAt: String
        let participants: [Owner]
        let type: String
        let geo: [Int]
        let picture, preview: String

        enum CodingKeys: String, CodingKey {
            case id, name, description, owner
            case startAt = "start_at"
            case endAt = "end_at"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case participants, type, geo, picture, preview
        }
    }
    struct Owner: Codable {
        let id: Int
        let name, email, avatar, createdAt: String
        let updatedAt, apiToken: String

        enum CodingKeys: String, CodingKey {
            case id, name, email, avatar
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case apiToken = "api_token"
        }
    }
}
