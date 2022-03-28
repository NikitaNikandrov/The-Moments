//
//  ViewController.swift
//  The Moments
//
//  Created by Никита on 22.09.2021.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //Mark: Constants
    private let requestServices = RequestServices()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let logoImage = UIImage(named: "momentsLogo.png")
        imageView.image = logoImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "The Moments"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Login",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.shared.black,
                         .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = AppColors.shared.grey
        textField.textColor = AppColors.shared.black
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 20
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.shared.black,
                         .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = AppColors.shared.grey
        textField.textColor = AppColors.shared.black
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 20
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColors.shared.lightBlue
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.titleLabel?.textColor = .white
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInButtonIsPressed), for: .touchUpInside)
        return button
    }()
    
    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet ?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColors.shared.lightBlue
        let buttonLabelAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white,
                                                                    .font: UIFont.systemFont(ofSize: 18, weight: .regular),
                                                                    .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "Sign Up", attributes: buttonLabelAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonIsPressed), for: .touchUpInside)
        return button
    }()
    
    //Mark: Variables
    private var presenter: LoginPresenter!
    
    //Mark: Button's actions
    @objc func logInButtonIsPressed(sender: UIButton!){
      
        /* let login = String(loginTextField.text!)
        let password = String(passwordTextField.text!)
        requestServices.logInRequest(Login: login, Password: password) { (result, message) in
            guard let result = result else {
                DispatchQueue.main.async {
                    self.failAuthAlert(message: message)
                }
                return
            }
            self.presenter.responseAuthHandling(response: result)
            DispatchQueue.main.async {
                self.okAuthAlert()
            }
        }*/
     
        let tabBarVC = UITabBarController()
        //favourit
        let myMeetings = UINavigationController(rootViewController: FavoritsViewController())
        myMeetings.title = "Favorits meetings"
        let favoritesItem = UITabBarItem(title: myMeetings.title, image: UIImage(systemName: "star"), tag: 0)
        myMeetings.tabBarItem = favoritesItem
        
        //search
        let searchMeetings = UINavigationController(rootViewController: SearchMeetingsViewController())
        searchMeetings.title = "Search meetings"
        let searchItem = UITabBarItem(title: searchMeetings.title, image: UIImage(systemName: "magnifyingglass"), tag: 0)
        searchMeetings.tabBarItem = searchItem
        
        //account
        let account = UINavigationController(rootViewController: AccountViewController())
        account.title = "My account"
        let accountItem = UITabBarItem(title: account.title, image: UIImage(systemName: "person"), tag: 0)
        account.tabBarItem = accountItem
        
        tabBarVC.setViewControllers([myMeetings, searchMeetings, account], animated: false)
        
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemApperance = UITabBarItemAppearance()
            
            tabBarAppearance.configureWithOpaqueBackground()
            
            tabBarItemApperance.normal.iconColor = .black
            tabBarItemApperance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            tabBarItemApperance.selected.iconColor = .white
            tabBarItemApperance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            tabBarAppearance.backgroundColor = AppColors.shared.lightBlue
            tabBarAppearance.stackedLayoutAppearance = tabBarItemApperance
            
            tabBarVC.tabBar.standardAppearance = tabBarAppearance
            tabBarVC.tabBar.scrollEdgeAppearance = tabBarAppearance
           
        } else {
            tabBarVC.tabBar.tintColor = UIColor.white
            tabBarVC.tabBar.unselectedItemTintColor = UIColor.black
            tabBarVC.tabBar.barTintColor = AppColors.shared.lightBlue
        }
       
        tabBarVC.modalPresentationStyle = .fullScreen
        
        present(tabBarVC, animated: true)
       
    }
    
    @objc func signUpButtonIsPressed(sender: UIButton!){
       let registerViewController = RegisterViewController()
        self.present(registerViewController, animated: true, completion: nil)
    }
    
    //Mark: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenter()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        setUpVC()
    }
}

extension LogInViewController {
    
    func setUpVC() {
        
        view.backgroundColor = AppColors.shared.blue
        
        view.addSubview(logoImageView)
        setLogoImageConstraints()
        
        view.addSubview(logoLabel)
        setLogoLabelConstraints()
        
        view.addSubview(loginTextField)
        setLoginTextFieldConstraints()
        
        view.addSubview(passwordTextField)
        setPasswordTextFieldConstraints()
        
        view.addSubview(logInButton)
        setLogInButtonConstraints()
        
        view.addSubview(noAccountLabel)
        setNoAccountLabelConstraints()
        
        view.addSubview(signUpButton)
        setSignUpButtonConstraints()
    }
    
    func failAuthAlert(message: String) {
        let alert = UIAlertController(title: "Ops, error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    //only for test
    func okAuthAlert() {
        let alert = UIAlertController(title: "Correct", message: "Молодец, пора сделать главный экран прилы", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    //Mark: Hide keyboard with done button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true;
    }
    
    //Outlets
    func setLogoImageConstraints() {
        NSLayoutConstraint(item: logoImageView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 200).isActive = true
        NSLayoutConstraint(item: logoImageView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 200).isActive = true
        NSLayoutConstraint(item: logoImageView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 44).isActive = true
        NSLayoutConstraint(item: logoImageView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setLogoLabelConstraints() {
        NSLayoutConstraint(item: logoLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 28).isActive = true
        NSLayoutConstraint(item: logoLabel,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 150).isActive = true
        NSLayoutConstraint(item: logoLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 270).isActive = true
        NSLayoutConstraint(item: logoLabel,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setLoginTextFieldConstraints() {
        NSLayoutConstraint(item: loginTextField,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 55).isActive = true
        NSLayoutConstraint(item: loginTextField,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 310).isActive = true
        NSLayoutConstraint(item: loginTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 322).isActive = true
        NSLayoutConstraint(item: loginTextField,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setPasswordTextFieldConstraints() {
        NSLayoutConstraint(item: passwordTextField,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 55).isActive = true
        NSLayoutConstraint(item: passwordTextField,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 310).isActive = true
        NSLayoutConstraint(item: passwordTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 387).isActive = true
        NSLayoutConstraint(item: passwordTextField,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setLogInButtonConstraints() {
        NSLayoutConstraint(item: logInButton,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 50).isActive = true
        NSLayoutConstraint(item: logInButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 170).isActive = true
        NSLayoutConstraint(item: logInButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 460).isActive = true
        NSLayoutConstraint(item: logInButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setNoAccountLabelConstraints() {
        NSLayoutConstraint(item: noAccountLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 21).isActive = true
        NSLayoutConstraint(item: noAccountLabel,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 250).isActive = true
        NSLayoutConstraint(item: noAccountLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 530).isActive = true
        NSLayoutConstraint(item: noAccountLabel,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setSignUpButtonConstraints() {
        NSLayoutConstraint(item: signUpButton,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 50).isActive = true
        NSLayoutConstraint(item: signUpButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 170).isActive = true
        NSLayoutConstraint(item: signUpButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 575).isActive = true
        NSLayoutConstraint(item: signUpButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
}
