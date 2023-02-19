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
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .black
        
        tabBar.layer.backgroundColor = Resources.Colors.lightBlue.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let favoritsViewController = FavoritsViewController()
        let searchMeetingsViewController = SearchMeetingsViewController()
        let accountViewController = AccountViewController()
        
        let favoritsNavigationController = NavBarController(rootViewController: favoritsViewController)
        let searchMeetingsNavigationController = NavBarController(rootViewController: searchMeetingsViewController)
        let accountNavigationController = NavBarController(rootViewController: accountViewController)
        
        favoritsViewController.tabBarItem = UITabBarItem(title: Resources.TabBarResources.TabBarItemsStrings.favorits,
                                                         image: Resources.TabBarResources.TabBarItemsImages.favorits,
                                                         tag: Tabs.favorits.rawValue)
        searchMeetingsViewController.tabBarItem = UITabBarItem(title: Resources.TabBarResources.TabBarItemsStrings.search,
                                                               image: Resources.TabBarResources.TabBarItemsImages.search,
                                                               tag: Tabs.search.rawValue)
        accountViewController.tabBarItem = UITabBarItem(title: Resources.TabBarResources.TabBarItemsStrings.account,
                                                        image: Resources.TabBarResources.TabBarItemsImages.account,
                                                        tag: Tabs.account.rawValue)
        
        setViewControllers([favoritsNavigationController,
                            searchMeetingsNavigationController,
                            accountNavigationController], animated: false)
    }
}
