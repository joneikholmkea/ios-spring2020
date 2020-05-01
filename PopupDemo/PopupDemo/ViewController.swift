//
//  ViewController.swift
//  PopupDemo
//
//  Created by Jon Eikholm on 01/05/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showBtnPressed(_ sender: UIButton) {
    // present popup
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            if let destination = segue.destination as? PopUpViewController {
                destination.preferredContentSize = CGSize(width:250,height:250) // runtime size
                destination.parentVC = self
                let presentationController = destination.popoverPresentationController
                presentationController?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    func handleReturnFromPopup(txt:String) {
        print("returned from popup with \(txt)")
    }
    

}

