//
//  ViewController.swift
//  MediaCaptureDemo
//
//  Created by Jon Eikholm on 27/03/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController() // will handle the task of fetching an image from the iOS system
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // assign the object from this class to handle image picking return.
    }

    @IBAction func photosBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary // what type of task: camera or photoalbum
        imagePicker.allowsEditing = true // should the user be able to zoom in before getting the image
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("returned from image picking")
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
}

