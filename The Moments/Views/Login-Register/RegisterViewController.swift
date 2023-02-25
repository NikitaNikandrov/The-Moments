//
//  RegisterViewController.swift
//  The Moments
//
//  Created by Никита on 01.01.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: Constats
    let requestServices = AuthenticationRequestService()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let logoImage = UIImage(named: Resources.AppImageStrings.logoImage)
        imageView.image = logoImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let createLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.RegisterVCStrings.createLabelString
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString( string: Resources.RegisterVCStrings.nameTextFieldString,
                                                              attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.black,
                                                                           .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = Resources.Colors.grey
        textField.textColor = Resources.Colors.black
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
        textField.attributedPlaceholder = NSAttributedString( string: Resources.RegisterVCStrings.emailTextfieldString,
                                                              attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.black,
                                                                           .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = Resources.Colors.grey
        textField.textColor = Resources.Colors.black
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
        textField.attributedPlaceholder = NSAttributedString( string: Resources.RegisterVCStrings.passwordTextfieldString,
                                                              attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.black,
                                                                           .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = Resources.Colors.grey
        textField.textColor = Resources.Colors.black
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
        textField.attributedPlaceholder = NSAttributedString( string: Resources.RegisterVCStrings.confirmPasswordTextfieldString,
                                                              attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.black,
                                                                           .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = Resources.Colors.grey
        textField.textColor = Resources.Colors.black
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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Resources.Colors.lightBlue
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
    
    // MARK: variables
    private var activeTextField: UITextField?
    private var viewModel = RegisterViewModel()
    
    // MARK: Actions
    
    @objc func signUpButtonIsPressed(sender: UIButton!) {
        
        var requestData = MethodArguments.RegisterUserArguments()
        requestData.name = String(nameTextField.text!)
        requestData.email = String(emailTextField.text!)
        requestData.password = String(passwordTextField.text!)
        
        viewModel.signUpButtonIsPressed(registerArguments: requestData)
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        prepareVC()
        bindViewModel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func bindViewModel() {
        viewModel.registerResult.bind { [weak self] registerResult in
            DispatchQueue.main.async {
                switch registerResult {
                case .succes:
                    self?.viewModel.alertMessage.bind { [weak self] (message) in
                        DispatchQueue.main.async {
                            self?.successAuthAlert(name: message)
                        }
                    }
                case .fail:
                    self?.viewModel.alertMessage.bind { [weak self] (message) in
                        DispatchQueue.main.async {
                            self?.failAuthAlert(message: message)
                        }
                    }
                case .unknowned:
                    return
                }
            }
        }
    }
    
    private func prepareVC() {
        
        view.backgroundColor = Resources.Colors.blue
        
        self.view.addSubview(logoImageView)
        setLogoImageConstraints()
        
        self.view.addSubview(createLabel)
        setCreateLabelConstraints()
        
        self.view.addSubview(nameTextField)
        setLoginTextFieldConstraints()
        
        self.view.addSubview(emailTextField)
        setEmailTextField()
        
        self.view.addSubview(passwordTextField)
        setPasswordTextFieldConstraints()
        
        self.view.addSubview(confirmPasswordTextField)
        setConfirmPasswordTextFieldConstraints()
        
        self.view.addSubview(passwordLabel)
        setPasswordLabelConstraints()
        
        self.view.addSubview(signUpButton)
        setSignUpButtonConstraints()
        
        passwordLabel.isHidden = true
    }
    
    private func  successAuthAlert(name: String) {
        let message = name + " has been registered"
        let alert = UIAlertController(title: "Successful", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)})
        self.present(alert, animated: true)
    }
    
    private func failAuthAlert(message: String) {
        let alert = UIAlertController(title: "Ops, error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Constraints
    
    private func setLogoImageConstraints() {
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setCreateLabelConstraints() {
        createLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        createLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        createLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270).isActive = true
        createLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setLoginTextFieldConstraints() {
        nameTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 322).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setEmailTextField() {
        emailTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 387).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setPasswordTextFieldConstraints() {
        passwordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 452).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setConfirmPasswordTextFieldConstraints() {
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 517).isActive = true
        confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setPasswordLabelConstraints() {
        passwordLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 595).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setSignUpButtonConstraints() {
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 640).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let chek = viewModel.passwordManager(password: String(passwordTextField.text!),
                                             confirmPassword: String(confirmPasswordTextField.text!))
        switch chek {
        case .hideLabel:
            passwordLabel.isHidden = true
        case .min6char:
            passwordLabel.text = "Min 6 characters"
            passwordLabel.isHidden = false
        case .differentPass:
            passwordLabel.text = "The passwords are different"
            passwordLabel.isHidden = false
        case .ok:
            passwordLabel.isHidden = true
        }
        self.activeTextField = nil
    }
}

extension RegisterViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var shouldMoveViewUp = false
        var deltaOfHide = CGFloat(0)
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if (bottomOfTextField > topOfKeyboard) || (topOfKeyboard - bottomOfTextField <= CGFloat(20)) {
                shouldMoveViewUp = true
                deltaOfHide = bottomOfTextField - topOfKeyboard + CGFloat(20)
            }
        }
        
        if shouldMoveViewUp {
            self.view.frame.origin.y = 0 - deltaOfHide
            deltaOfHide = CGFloat(0)
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
