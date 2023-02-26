//
//  MeetingsJSONModel.swift
//  The Moments
//
//  Created by Никита on 26.02.2023.
//

import Foundation

class MeetingsJSONModel {
    struct MeetingsJSONModel: Codable {
        let code: Int?
        let success: Bool?
        let serviceData: ServiceData
    }

    struct ServiceData: Codable {
        let perPage, currentPage, lastPage: Int?
        let data: [Meeting]?

        enum CodingKeys: String, CodingKey {
            case perPage = "per_page"
            case currentPage = "current_page"
            case lastPage = "last_page"
            case data
        }
    }

    struct Meeting: Codable {
        let id: Int?
        let name, description: String?
        let startAt, endAt: String?
        let type: String?
        let geo: String?
        let owner: Owner?
        let avatar: Avatar?

        enum CodingKeys: String, CodingKey {
            case id, name, description
            case startAt = "start_at"
            case endAt = "end_at"
            case type, geo, owner, avatar
        }
    }

    struct Avatar: Codable {
        let id: Int
        let image: String?
        let size: Int?
        let preview: [Avatar]?
    }

    
    struct Owner: Codable {
        let id: Int?
        let name: String?
        let firstName, lastName, middleName, phone: String?
        let dateBirth: String?
        let avatar: Avatar?

        enum CodingKeys: String, CodingKey {
            case id, name
            case firstName = "first_name"
            case lastName = "last_name"
            case middleName = "middle_name"
            case phone
            case dateBirth = "date_birth"
            case avatar
        }
    }
}
