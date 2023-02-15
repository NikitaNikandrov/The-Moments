//
//  ColorConverter.swift
//  The Moments
//
//  Created by Никита on 07.02.2022.
//

import Foundation
import UIKit

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
