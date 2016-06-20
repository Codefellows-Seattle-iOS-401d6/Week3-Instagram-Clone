//
//  ImageViewController.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func setupAppearance() {
        //customize image to have rounded corners
        self.imageView.layer.cornerRadius = 3.0
    }
    
    func setup() {
        self.navigationItem.title = "INSTGRM"
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        // this is interested in the events. sets deleate, sets source type, presents image picker
        // view controller needs to conform to UIImagePickerControllerDelegate and UINavigationControllerDelegate protocols
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func presentActionSheet() {
        // we need to check if user has camera and then present choices for user
        let actionSheet = UIAlertController(title: "Source", message: "select source type", preferredStyle: .ActionSheet)
        
        //now create actions: cameraAction, photoAction, cancelAction
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            // calling imagePicker and calling the source type
            self.presentImagePicker(.Camera)
        }
        
        let photoAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    // now handle image selection - implementing two delegates on imagePicker
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image // passed in as param of delegate function
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

