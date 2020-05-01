//
//  PopUpViewController.swift
//  PopupDemo
//
//  Created by Jon Eikholm on 01/05/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var parentVC:ViewController? // parent viewController, so we can pass the text entered.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        if let txt = textField.text {
            parentVC?.handleReturnFromPopup(txt: txt) //
            print("in popup \(txt)")
        }
        
    }


}
