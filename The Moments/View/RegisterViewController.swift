//
//  RegisterViewController.swift
//  The Moments
//
//  Created by Никита on 01.01.2022.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

//Mark: Constats
    let requestServices = RequestServices()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let logoImage = UIImage(named: "momentsLogo.png")
        imageView.image = logoImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let createLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
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
    
    private let emailTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
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
    
    private let confirmPasswordTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Confirm password",
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
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "The passwords are different !"
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
        return button
    }()
    
//Mark: variables
    private var presenter: RegisterPresenter!

//Mark: Actions
    @objc func comparePasswords(sender: UIButton!) {
        if presenter.comparePassword(password: String(loginTextField.text!) , confirmPassword: String(confirmPasswordTextField.text!)) {
            self.passwordLabel.isHidden = true
            if String(confirmPasswordTextField.text!) != "" {
                self.signUpButton.isEnabled = true
            }
        } else {
            self.passwordLabel.isHidden = false
        }
    }
    
    @objc func signUpButtonIsPressed(sender: UIButton!) {
        /*
        var requestData = MethodArguments.AuthUserArguments()
        requestData.login = String(loginTextField.text!)
        requestData.password = String(passwordTextField.text!)
        requestData.confirmPassword = String(confirmPasswordTextField.text!)
        requestServices.registerRequest(RegisterArguments: requestData) { data in
                guard let data = data else {
                    print("request failed")
                    return
                }
            }
         */
         }
  
//Mark: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegisterPresenter()
        
        loginTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        setUpVC()
    }
}

extension RegisterViewController {
    
    func setUpVC() {
        
        view.backgroundColor = AppColors.shared.blue
        
        view.addSubview(logoImageView)
        setLogoImageConstraints()
        
        view.addSubview(createLabel)
        setCreateLabelConstraints()
        
        view.addSubview(loginTextField)
        setLoginTextFieldConstraints()
        
        view.addSubview(emailTextField)
        setEmailTextField()
        
        view.addSubview(passwordTextField)
        setPasswordTextFieldConstraints()
        
        view.addSubview(confirmPasswordTextField)
        setConfirmPasswordTextFieldConstraints()
        
        view.addSubview(passwordLabel)
        setPasswordLabelConstraints()
        
        view.addSubview(signUpButton)
        setSignUpButtonConstraints()
        
        passwordLabel.isHidden = true
        signUpButton.isEnabled = false
    }
    
    //Constraints
    func setLogoImageConstraints() {
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setCreateLabelConstraints() {
        createLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        createLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        createLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270).isActive = true
        createLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setLoginTextFieldConstraints() {
        loginTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 322).isActive = true
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setEmailTextField() {
        emailTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 387).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setPasswordTextFieldConstraints() {
        passwordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 452).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setConfirmPasswordTextFieldConstraints() {
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 517).isActive = true
        confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setPasswordLabelConstraints() {
        passwordLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 595).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setSignUpButtonConstraints() {
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 640).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
}
