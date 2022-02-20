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
        id = 0
        name = ""
        avatar = ""
        apiToken = ""
    }
    var id: Int
    var name, avatar, apiToken: String
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

final class AppColors {
    static var shared = AppColors()
    private init() {
        blue = UIColor(hexString: "4E8AFE")
        lightBlue = UIColor(hexString: "7FA1E3")
        grey = UIColor(hexString: "ECECEC")
        black = UIColor(hexString: "777777")
    }
    var blue, lightBlue, grey, black: UIColor
    
}
