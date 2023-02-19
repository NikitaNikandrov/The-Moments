//
//  SearchMeetingsViewController.swift
//  The Moments
//
//  Created by Никита on 10.02.2022.
//

import UIKit

class SearchMeetingsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchVC()
    }
}

extension SearchMeetingsViewController {

    func setUpSearchVC() {

        self.title = "Search meetings"
        self.tabBarItem.title = Resources.TabStrings.search
    }
}
