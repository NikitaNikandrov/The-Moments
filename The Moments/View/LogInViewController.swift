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
    
    //Mark: Variables
    private var presenter: LoginPresenter!
    
    private var loginTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
                                            string: "Login",
                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "777777"),
                                                         .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = UIColor(hexString: "ECECEC")
        textField.textColor = UIColor(hexString: "777777")
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 20
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
                                            string: "Password",
                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "777777"),
                                                         .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.backgroundColor = UIColor(hexString: "ECECEC")
        textField.textColor = UIColor(hexString: "777777")
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 20
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
     /* //Mark: Autlets buttons
     @IBOutlet weak var logInButton: UIButton!
     @IBOutlet weak var signUpButton: UIButton!
     
     //Mark: Button's actions
     @IBAction func logInButtonIsPressed(_ sender: Any) {
     let login = String(loginTextField.text!)
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
     }
     }
     
     @IBAction func SignUpButtonIsPressed(_ sender: Any) {
     let registerViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerVC") as UIViewController
     self.present(registerViewController, animated: true, completion: nil)
     } */
    
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
        let backgroundColor = UIColor(hexString: "4E8AFE")
        view.backgroundColor = backgroundColor
        
        view.addSubview(logoImageView)
        setLogoImageConstraints()
        
        view.addSubview(logoLabel)
        setLogoLabelConstraints()
        
        view.addSubview(loginTextField)
        setLoginTextFieldConstraints()
        
        view.addSubview(passwordTextField)
        setPasswordTextFieldConstraints()
    }
    /*
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
     */
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
                           attribute: .topMargin,
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
}
