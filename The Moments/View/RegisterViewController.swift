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
/*
//Mark: Actions
    @IBAction func comparePasswords(_ sender: Any) {
        if presenter.comparePassword(password: String(loginTextField.text!) , confirmPassword: String(confirmPasswordTextField.text!)) {
            self.passwordLabel.isHidden = true
            if String(confirmPasswordTextField.text!) != "" {
                self.signUpButton.isEnabled = true
            }
        } else {
            self.passwordLabel.isHidden = false
        }
    }
    @IBAction func signUpButtonIsPressed(_ sender: Any) {
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
    }
  */
//Mark: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegisterPresenter()
        /*
        loginTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        */
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
        
        view.addSubview(passwordTextField)
        setPasswordTextFieldConstraints()
        
        view.addSubview(confirmPasswordTextField)
        setConfirmPasswordTextFieldConstraints()
        
        view.addSubview(passwordLabel)
        setPasswordLabelConstraints()
        
        view.addSubview(signUpButton)
        setSignUpButtonConstraints()
        
        /*
        passwordLabel.isHidden = true
        signUpButton.isEnabled = false*/
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
                           attribute: .topMargin,
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
    
    func setCreateLabelConstraints() {
        NSLayoutConstraint(item: createLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 28).isActive = true
        NSLayoutConstraint(item: createLabel,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 200).isActive = true
        NSLayoutConstraint(item: createLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
                           constant: 270).isActive = true
        NSLayoutConstraint(item: createLabel,
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
                           attribute: .topMargin,
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
                           attribute: .topMargin,
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
    
    func setConfirmPasswordTextFieldConstraints() {
        NSLayoutConstraint(item: confirmPasswordTextField,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 55).isActive = true
        NSLayoutConstraint(item: confirmPasswordTextField,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 310).isActive = true
        NSLayoutConstraint(item: confirmPasswordTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
                           constant: 456).isActive = true
        NSLayoutConstraint(item: confirmPasswordTextField,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func setPasswordLabelConstraints() {
        NSLayoutConstraint(item: passwordLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 21).isActive = true
        NSLayoutConstraint(item: passwordLabel,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 250).isActive = true
        NSLayoutConstraint(item: passwordLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
                           constant: 530).isActive = true
        NSLayoutConstraint(item: passwordLabel,
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
                           attribute: .topMargin,
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
