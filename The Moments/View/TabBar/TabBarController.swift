//
//  TabBarController.swift
//  The Moments
//
//  Created by Никита on 15.02.2023.
//

import UIKit

enum Tabs: Int {
    case favorits
    case search
    case account
    case settings
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tabBar.tintColor = Resources.Colors.blue
        tabBar.barTintColor = Resources.Colors.grey
        tabBar.backgroundColor = .white
        
        tabBar.layer.backgroundColor = Resources.Colors.grey.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let favoritsViewController = FavoritsViewController()
        let searchMeetingsViewController = SearchMeetingsViewController()
        let accountViewController = AccountViewController()
        
        let favoritsNavigationController = UINavigationController(rootViewController: favoritsViewController)
        let searchMeetingsNavigationController = UINavigationController(rootViewController: searchMeetingsViewController)
        let accountNavigationController = UINavigationController(rootViewController: accountViewController)
        
        favoritsViewController.tabBarItem = UITabBarItem(title: Resources.TabStrings.favorits,
                                                         image: Resources.TabImages.favorits,
                                                         tag: Tabs.favorits.rawValue)
        searchMeetingsViewController.tabBarItem = UITabBarItem(title: Resources.TabStrings.search,
                                                               image: Resources.TabImages.search,
                                                               tag: Tabs.search.rawValue)
        accountViewController.tabBarItem = UITabBarItem(title: Resources.TabStrings.account,
                                                        image: Resources.TabImages.account,
                                                        tag: Tabs.account.rawValue)
        
        setViewControllers([favoritsViewController,
                           searchMeetingsViewController,
                           accountViewController],
                           animated: false)
    }
}
