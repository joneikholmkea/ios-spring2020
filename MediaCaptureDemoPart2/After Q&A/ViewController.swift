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
    
    @IBAction func cameraVideoBtnPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"]  // will launch the video in the camera app
        imagePicker.videoQuality = .typeMedium // set quality level
        launchCamera()
    }
    
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoBtnPressed(_ sender: UIButton) {
        launchCamera()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // we either have an image, or a video
        // 1. if its a video, do this
        if let url = info[.mediaURL] as? URL { // this will only be true, if there is a video
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil) // minimal version of save
            }
        }else { // if we have an image:
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    var startPoint = CGFloat(0) // will be set, when the touch begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view){
            startPoint = p.x  // register the x-position of finger
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view){
            let diff = p.x - startPoint // calculate the difference between the first touch, and current finger position
            // get the difference of your finger movement
            imageView.transform = CGAffineTransform(translationX: diff, y: 0)
            // check how far the image has been moved
            // if beyond a limit (right), then remove the image
            // if beyond a limit (left), then save the image
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // when the user lets go of the screen
    }
    
    func setTextOnImage(txt:String) {
        
        //UIGraphicsBeginImageContext(<#T##size: CGSize##CGSize#>)
        // draw the image, using its draw()
        //NSAttributedString
    }
    
}

