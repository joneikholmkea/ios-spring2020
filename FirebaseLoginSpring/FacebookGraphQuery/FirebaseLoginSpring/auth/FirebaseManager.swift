//
//  FirebaseManager.swift
//  FirebaseLoginSpring
//
//  Created by Jon Eikholm on 03/04/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager{
    
    var auth = Auth.auth() // Firebase authentication class.
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
                if user != nil {
                    print("Status: user is logged in: \(user)") // show some GUI
                }else {
                               print("Status: user is logged out") // hide content
                    // hide the secretVC here
                }
         }
    }
    
    func signUp(email:String, pwd:String) {
         auth.createUser(withEmail: email, password: pwd) { (result, error) in
             if error == nil { // success
                 print("successfully signed up to Firebase \(result.debugDescription)")
             }else {
                 print("Failed to log in \(error.debugDescription)")
             }
         }
     }
     
     func signIn(email:String, pwd:String) {
         auth.signIn(withEmail: email, password: pwd) { (result, error) in
             if error == nil { // success
                    print("successfully logged in to Firebase \(result.debugDescription)")
                    // call parentVC to display something, such as parentVC.showPanel()
                    self.parentVC.presentSecretVC()
                    }else {
                    print("Failed to log in \(error.debugDescription)")
             }
         }
     }
    
    func signInUsingFacebook(tokenString:String) {
       // call Firebase, using credentials from Facebook.
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        auth.signIn(with: credential) { (result, error) in
            if error == nil {
                print("logged in to firebase, using facebook \(result?.description)")
            }else {
                print("Failed to login to firebase, using facebook \(error.debugDescription)")
            }
        }
    }
     
    func signOut() {
         do {
             try auth.signOut()
         }catch let error{
             print("error signing out \(error.localizedDescription)")
         }
     }
    
}
