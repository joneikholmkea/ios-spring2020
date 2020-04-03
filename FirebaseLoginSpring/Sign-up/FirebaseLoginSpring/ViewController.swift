//
//  ViewController.swift
//  FirebaseLoginSpring
//
//  Created by Jon Eikholm on 03/04/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var auth = Auth.auth() // Firebase authentication class.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text { // check if there is enough text
            if email.count > 5 && pwd.count > 5{
                signUp(email: email, pwd: pwd)
            }
        }
    }
    
    func signUp(email:String, pwd:String) {
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if error == nil { // success
                print("successfully logged in to Firebase \(result.debugDescription)")
            }else {
                print("Failed to log in \(error.debugDescription)")
            }
        }
    }
    
}

