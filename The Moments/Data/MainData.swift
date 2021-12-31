//
//  MainData.swift
//  The Moments
//
//  Created by Никита on 31.12.2021.
//

import Foundation

final class MainData {
    static var shared = MainData()
    private init() {
        id = 0
        name = ""
        avatar = ""
        apiToken = ""
    }
    var id: Int
    var name, avatar, apiToken: String
}
//klhfjn
