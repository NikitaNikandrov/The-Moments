//
//  MainViewController.swift
//  The Moments
//
//  Created by Никита on 08.02.2022.
//

import UIKit

class FavoritsViewController: UIViewController {

    let testArray = ["1","2","3","4"/*,"1","2","3","4","1","2","3","4","5","6","7","8","1","2","3","4","5"*/]
    let favouritsTableView: UITableView = {
        let favourits = UITableView()
        favourits.translatesAutoresizingMaskIntoConstraints = false
        return favourits
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFavouritsVC()
        view.addSubview(favouritsTableView)
        setTableViewConstraints()
        
        favouritsTableView.delegate = self
        favouritsTableView.dataSource = self
        favouritsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
}

extension FavoritsViewController {
    
    func setUpFavouritsVC() {
    
        view.backgroundColor = AppColors.shared.blue
        //Setting colors nav bar
        self.navigationController?.navigationBar.backgroundColor = AppColors.shared.lightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "Favorits meetings"
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

        //Setting colors for tableview
        self.favouritsTableView.backgroundColor = AppColors.shared.blue
        self.favouritsTableView.separatorColor = UIColor.white
    }
    
    func setTableViewConstraints() {
        favouritsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        favouritsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        favouritsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        favouritsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
}

extension FavoritsViewController: UITableViewDelegate, UITableViewDataSource {
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
