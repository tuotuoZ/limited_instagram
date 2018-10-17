//
//  captureViewController.swift
//  limitied instagram
//
//  Created by Tony Zhang on 10/16/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit
import Parse

class captureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var uploadCaption: UITextField!
    @IBOutlet weak var uploadImageView: UIImageView!
    var uploadImage: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    
    // bug for calling a camara
    func takePhoto() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
      
        var originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        var editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage

        
        
        // print out the image size as a test
        dismiss(animated: true, completion: nil)
    }

    func pickPhoto(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
   
    func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: image)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption!
        post.likesCount = 0
        post.commentsCount = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
}

