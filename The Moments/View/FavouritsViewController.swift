//
//  MainViewController.swift
//  The Moments
//
//  Created by Никита on 08.02.2022.
//

import UIKit

class FavouritsViewController: UIViewController {

    let testArray = ["сосать члены","ебаться в пьер да челло","нюхать бэбру"]
    let favouritsTableView: UITableView = {
        let favourits = UITableView()
        favourits.translatesAutoresizingMaskIntoConstraints = false
        return favourits
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(favouritsTableView)
        setTableViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritsTableView.delegate = self
        favouritsTableView.dataSource = self
        favouritsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setUpFavouritsVC()
    }
    
}

extension FavouritsViewController {
    
    func setUpFavouritsVC() {
    
        view.backgroundColor = AppColors.shared.blue
        //Setting colors nav bar
        self.navigationController?.navigationBar.backgroundColor = AppColors.shared.lightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "Favourit meetings"
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
        //Setting colors for tableview
        self.favouritsTableView.backgroundColor = AppColors.shared.blue
        self.favouritsTableView.separatorColor = UIColor.white
    }
    
    func setTableViewConstraints() {
        NSLayoutConstraint(item: favouritsTableView, attribute: .top,
                           relatedBy: .equal, toItem: view,
                           attribute: .top, multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: favouritsTableView, attribute: .bottom,
                           relatedBy: .equal, toItem: view,
                           attribute: .bottom, multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: favouritsTableView, attribute: .leading,
                           relatedBy: .equal, toItem: view,
                           attribute: .leading, multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: favouritsTableView, attribute: .trailing,
                           relatedBy: .equal, toItem: view,
                           attribute: .trailing, multiplier: 1,
                           constant: 0).isActive = true
    }
}

extension FavouritsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(testArray[indexPath.row])"
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = AppColors.shared.blue
        
        return cell
    }
    
    
}
