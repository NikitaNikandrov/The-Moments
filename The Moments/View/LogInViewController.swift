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
    @objc func logInButtonIsPressed(sender: UIButton!) {
        
        let login = String(loginTextField.text!)
        let password = String(passwordTextField.text!)
        requestServices.logInRequest(login: login, password: password) { [weak self] result in
            switch result {
            case .sucsess(_):
                self?.presentFavoritsVC()
            case let .error(code, message):
                self?.failAuthAlert(code: code, message: message)
            }
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    func presentFavoritsVC() {
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
    
    func failAuthAlert(code: Int, message: String) {
        let erorrMessage = "Code: " + String(code) + " " + message
        let alert = UIAlertController(title: "Ops, error", message: erorrMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //Mark: Hide keyboard with done button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    //Constraints
    func setLogoImageConstraints() {
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setLogoLabelConstraints() {
        logoLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        logoLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setLoginTextFieldConstraints() {
        loginTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 322).isActive = true
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setPasswordTextFieldConstraints() {
        passwordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 387).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setLogInButtonConstraints() {
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        logInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 460).isActive = true
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setNoAccountLabelConstraints() {
        noAccountLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        noAccountLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        noAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 530).isActive = true
        noAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setSignUpButtonConstraints() {
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 575).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
}
