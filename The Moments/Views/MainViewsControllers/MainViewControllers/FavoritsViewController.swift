//
//  MainViewController.swift
//  The Moments
//
//  Created by Никита on 08.02.2022.
//

import UIKit

class FavoritsViewController: BaseViewController {

    let testArray = ["1", "2", "3", "4"/*,"1","2","3","4","1","2","3","4","5","6","7","8","1","2","3","4","5"*/]
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
    
        self.title = "Favorits meetings"
        self.tabBarItem.title = Resources.TabBarResources.TabBarItemsStrings.favorits
        
        // Setting colors for tableview
        self.favouritsTableView.backgroundColor = Resources.Colors.blue
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
        cell.backgroundColor = Resources.Colors.blue

        return cell
    }

}
