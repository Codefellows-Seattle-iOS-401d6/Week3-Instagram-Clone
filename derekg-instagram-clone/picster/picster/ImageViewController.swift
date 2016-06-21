//
//  ImageViewController.swift
//  picster
//
//  Created by Derek Graham on 6/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit
import Foundation
import CloudKit



class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
//        imagePicker.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setup()
    {
        self.navigationItem.title = "PicSter"
    }
    
    func setupAppearance()
    {
        self.imageView.layer.cornerRadius = 3.0
    }
    
    func presentImagePicker(sourcetype: UIImagePickerControllerSourceType){
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourcetype
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func presentActionSheet(){
        let actionSheet = UIAlertController(title: "Source", message: "Please choose a source for your photos", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        
        let photosAction = UIAlertAction(title: "Photo Library", style: .Default ) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addButtonSelected(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
            
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, info: [String : AnyObject]?) {
        self.imageView.image = image
        

        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

