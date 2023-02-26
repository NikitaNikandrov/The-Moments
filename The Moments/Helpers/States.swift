//
//  StatusConditions.swift
//  The Moments
//
//  Created by Никита on 20.02.2023.
//

import Foundation

enum StatusState {
    case succes
    case fail
    case unknowned
}

enum PasswordState {
    case hideLabel
    case min6char
    case differentPass
    case ok
}

enum ResultOfResponse<T> {
    case sucsess(T)
    case error(Int, String)
}
