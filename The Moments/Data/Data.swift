//
//  MainData.swift
//  The Moments
//
//  Created by Никита on 31.12.2021.
//

import Foundation
import UIKit

final class PersonData {
    static var shared = PersonData()
    private init() {
        id = ""
        name = ""
        email = ""
        firstName = ""
        lastName = ""
        middleName = ""
        phone = ""
        dateBirth = ""
        token = ""
        avatar = Avatar()
    }
    var id, name, email, firstName: String
    var lastName, middleName, phone, dateBirth: String
    var token: String
    var avatar: Avatar
    
    struct Avatar {
        var id, image: String
        var preview: [Preview]
        init() {
            id = ""
            image = ""
            preview = [Preview()]
        }
    }
    struct Preview {
        var id, image, size: String
        init() {
            id = ""
            image = ""
            size = ""
        }
    }
}








final class MeetingsData {
    static var shared = MeetingsData()
    private init() {
        favouritMeetingsCollection = []
        searchingMeetingsCollection = []
    }
    var favouritMeetingsCollection: [MeetingDetails]
    var searchingMeetingsCollection: [MeetingDetails]
    
    struct MeetingDetails {
        var meetingName: String
        var meetingDate: String
        var meetingDescription: String
    }
}


