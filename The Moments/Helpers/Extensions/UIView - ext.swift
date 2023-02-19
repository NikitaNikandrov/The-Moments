//
//  UIView - ext.swift
//  The Moments
//
//  Created by Никита on 19.02.2023.
//

import UIKit

extension UIView {
    func addBottomBorder(color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        separator.frame = CGRect(x: 0,
                                 y: frame.height - height,
                                 width: frame.width,
                                 height: height)
        addSubview(separator)
    }
}