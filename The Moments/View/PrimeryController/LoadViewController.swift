//
//  LoadViewController.swift
//  The Moments
//
//  Created by Никита on 15.02.2023.
//

import UIKit

class LoadViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let logoImage = UIImage(named: Resources.AppImageStrings.logoImage)
        imageView.image = logoImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        makeServiceCall()
    }
    
    func setupVC(){
        view.backgroundColor = Resources.Colors.blue
        
        view.addSubview(logoImageView)
        setLogoImageConstraints()
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.tintColor = .white
        activityIndicator?.center = self.view.center
        self.view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
    }
    
    func makeServiceCall() {
        showActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator?.stopAnimating()
            SceneDelegate.shared?.rootViewController.showLoginScreen()
        }
        /*
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
            // navigate to protected page
        } else {
            // navigate to login screen
        }*/
   
        
    }
    
    //Mark: Setting Constreints
    func setLogoImageConstraints() {
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
    }
}
