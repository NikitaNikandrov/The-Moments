//
//  Resources.swift
//  The Moments
//
//  Created by Никита on 15.02.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static var blue = UIColor(hexString: "4E8AFE")
        static var lightBlue = UIColor(hexString: "7FA1E3")
        static var grey = UIColor(hexString: "ECECEC")
        static var black = UIColor(hexString: "777777")
    }
    
    enum TabImages {
        static var favorits = UIImage(systemName: "star")
        static var search = UIImage(systemName: "magnifyingglass")
        static var account = UIImage(systemName: "person")
    }
    
    enum TabStrings {
        static var favorits = "Favorits"
        static var search = "Search"
        static var account = "Account"
    }
}
