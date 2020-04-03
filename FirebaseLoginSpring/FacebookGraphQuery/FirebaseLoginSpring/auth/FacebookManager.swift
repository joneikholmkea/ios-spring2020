//
//  FacebookManager.swift
//  FirebaseLoginSpring
//
//  Created by Jon Eikholm on 03/04/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookManager {
    
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
    }
    
    func loginToFacebook(){
        print("facebook login")
              let manager = LoginManager()
              manager.logIn(permissions: [.publicProfile], viewController: parentVC) { (result) in
                      print("logged in to facebook \(result)")
                  switch result {
                      case .cancelled :
                          print("login was cancelled")
                          break
                      case .failed(let error) :
                          print("login failed \(error.localizedDescription)")
                          break
                      case let .success(granted: _, declined: _, token: token):
                          print("Facebook login success \(token.userID)")
                          self.parentVC.firebaseManager?.signInUsingFacebook(tokenString: token.tokenString)
                      }
              }
    }
    
    func makeGraphRequest() {
        if let tokenStr = AccessToken.current?.tokenString {
                   let graphRequest = GraphRequest(graphPath: "/me",
                                       parameters: ["fields":"id, name, email, picture.width(400)"],
                                       tokenString: tokenStr,
                                       version: Settings.defaultGraphAPIVersion,
                                       httpMethod: .get)
                   let connection = GraphRequestConnection()
                   connection.add(graphRequest) { (connection, result, error) in
                       if error == nil, let res = result {
                           let dict = res as! [String:Any] // cast to dictionary
                           let name = dict["name"] as! String
                           let email = dict["email"] as! String
                          
                           print("got data from Facebook. Name \(name), email \(email)")
                           print(dict)
                       }else {
                           print("Error getting data from Facebook \(error.debugDescription)")
                       }
                   }
                   connection.start()
               }
    }
}
