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
    var firebaseManager:FirebaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self) // enable firebaseManager to update GUI
    }
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text { // check if there is enough text
            if email.count > 5 && pwd.count > 5{
                firebaseManager?.signUp(email: email, pwd: pwd)
            }
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        // warning: Do not hide content based on this call. Do that in the addIDTokenDidChangeListener
        firebaseManager?.signOut()
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text { // check if there is enough text
                   if email.count > 5 && pwd.count > 5{
                    firebaseManager?.signIn(email: email, pwd: pwd)
                   }
        }
    }
    
}

