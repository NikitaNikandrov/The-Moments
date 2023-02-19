//
//  PersonViewController.swift
//  The Moments
//
//  Created by Никита on 10.02.2022.
//

import UIKit

class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setAccountVC()
    }
}

extension AccountViewController {

    func setAccountVC() {

        self.title = "My account"
        self.tabBarItem.title = Resources.TabStrings.account
       
    }
}
