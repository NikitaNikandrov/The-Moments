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

//Mark: variables
    private var presenter: RegisterPresenter!

//Mark: Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    
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
    
//Mark: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVC()
    }
}

extension RegisterViewController {
    
    func setUpVC() {
        presenter = RegisterPresenter()
        
        passwordLabel.isHidden = true
        signUpButton.isEnabled = false
        loginTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
}
