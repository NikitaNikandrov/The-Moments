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
    private var presenter: LoginViewControllerPresenter!
    
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
        print(login)
        requestServices.logInRequest(Login: login, Password: password) { (result) in
            guard let response = result else {
                self.failAuthAlert()
                return
            }
            //self.presenter.responseAuthHandling(response: response)
            self.okAuthAlert()
        }
    }
//Mark: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }


}

extension LogInViewController {
    
    func setUpButtons(){
        self.logInButton.layer.borderWidth = 2
        self.logInButton.layer.borderColor = UIColor.white.cgColor
        self.logInButton.layer.cornerRadius = 19
        
        self.signUpButton.layer.borderWidth = 2
        self.signUpButton.layer.cornerRadius = 19
        self.signUpButton.layer.borderColor = UIColor.white.cgColor
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func failAuthAlert() {
        let alert = UIAlertController(title: "Incorrect login or password", message: "Please, try it again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func okAuthAlert() {
        let alert = UIAlertController(title: "Correct", message: "соси хуй и работай дальше", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
     {
     loginTextField.resignFirstResponder()
     passwordTextField.resignFirstResponder()
            return true;
        }
}
