//
//  ViewController.swift
//  The Moments
//
//  Created by Никита on 22.09.2021.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    //Mark: Autlets textfields
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

//Mark: Autlets buttons
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

//Mark: Button's actions
    @IBAction func logInButtonIsPressed(_ sender: Any) {
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
    }
}
