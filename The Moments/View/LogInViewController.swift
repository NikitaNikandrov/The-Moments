//
//  ViewController.swift
//  The Moments
//
//  Created by Никита on 22.09.2021.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //Mark: Constats
    let requestServices = RequestServices()
    //Mark: Variables
    private var presenter: LoginPresenter!
    
    //Mark: Autlet logo image
    @IBOutlet weak var logoImageView: UIImageView!
    //Mark: Autlets textfields
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Mark: Autlets buttons
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //Mark: Button's actions
    @IBAction func logInButtonIsPressed(_ sender: Any) {
        let login = String(loginTextField.text!)
        let password = String(passwordTextField.text!)
        requestServices.logInRequest(Login: login, Password: password) { (result, message) in
            guard let response = result else {
                DispatchQueue.main.async {
                    self.failAuthAlert(message: message)
                }
                return
            }
            self.presenter.responseAuthHandling(response: response)
            DispatchQueue.main.async {
                self.okAuthAlert()
            }
        }
    }
    
    @IBAction func SignUpButtonIsPressed(_ sender: Any) {
        let registerViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerVC") as UIViewController
        self.present(registerViewController, animated: true, completion: nil)
    }
    
    //Mark: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVC()
    }
    
    
}

extension LogInViewController {
    
    func setUpVC() {
        presenter = LoginPresenter()
        
        self.logInButton.layer.borderWidth = 2
        self.logInButton.layer.borderColor = UIColor.white.cgColor
        self.logInButton.layer.cornerRadius = 19
        
        self.signUpButton.layer.borderWidth = 2
        self.signUpButton.layer.cornerRadius = 19
        self.signUpButton.layer.borderColor = UIColor.white.cgColor
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
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
}
