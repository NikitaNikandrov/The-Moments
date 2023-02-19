//
//  BaseViewController.swift
//  The Moments
//
//  Created by Никита on 19.02.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    func setUp() {
        view.backgroundColor = Resources.Colors.blue
    }
}
