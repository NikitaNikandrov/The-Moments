//
//  PersonViewController.swift
//  The Moments
//
//  Created by Никита on 10.02.2022.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setAccountVC()
    }
}

extension AccountViewController {
    
    func setAccountVC() {
    
        view.backgroundColor = AppColors.shared.blue
        //Setting colors nav bar
        self.navigationController?.navigationBar.backgroundColor = AppColors.shared.lightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "My account"
        //Setting status bar background color
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = AppColors.shared.lightBlue
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        //Setting colors for tab bar
        self.tabBarController?.tabBar.backgroundColor = AppColors.shared.lightBlue
    }
}
