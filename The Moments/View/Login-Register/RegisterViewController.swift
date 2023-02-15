//
//  RegisterViewController.swift
//  The Moments
//
//  Created by Никита on 01.01.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: Constats
    let requestServices = AuthRequestServices()

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
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.lightBlue,
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "Confirm password",
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
        label.text = "The passwords are different !"
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
    private var presenter: RegisterPresenter!
    private var activeTextField: UITextField?

    // MARK: Actions

    @objc func signUpButtonIsPressed(sender: UIButton!) {

        var requestData = MethodArguments.RegisterUserArguments()
        requestData.login = String(loginTextField.text!)
        requestData.email = String(emailTextField.text!)
        requestData.password = String(passwordTextField.text!)
        requestServices.registerRequest(RegisterArguments: requestData) { [weak self] result in
            switch result {
            case let .sucsess(result):
                DispatchQueue.main.async {
                    self?.successAuthAlert(name: result.name!)
                }
            case let .error(code, message):
                DispatchQueue.main.async {
                    self?.failAuthAlert(code: code, message: message)
                }
            }
        }

    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = RegisterPresenter()

        loginTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self

        setUpVC()

        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {

    func  successAuthAlert(name: String) {
        let message = name + " has been registered"
        let alert = UIAlertController(title: "Successful", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)})
        self.present(alert, animated: true)
    }

    func failAuthAlert(code: Int, message: String) {
        let erorrMessage = "Code " + String(code) + ": " + message
        let alert = UIAlertController(title: "Ops, error", message: erorrMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let chek = presenter.passwordManager(password: String(passwordTextField.text!), confirmPassword: String(confirmPasswordTextField.text!))
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
           // signUpButton.isEnabled = true
        }
        self.activeTextField = nil
    }

    func setUpVC() {

        view.backgroundColor = Resources.Colors.blue

        self.view.addSubview(logoImageView)
        setLogoImageConstraints()

        self.view.addSubview(createLabel)
        setCreateLabelConstraints()

        self.view.addSubview(loginTextField)
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
        // signUpButton.isEnabled = false
    }

    // Constraints

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
