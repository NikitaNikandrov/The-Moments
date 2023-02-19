//
//  NavBarController.swift
//  The Moments
//
//  Created by Никита on 19.02.2023.
//

import UIKit

final class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
    }
    
    func setUpNavBar(){
        view.backgroundColor = Resources.Colors.lightBlue
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.addBottomBorder(color: .black, height: 1)
    }
}
