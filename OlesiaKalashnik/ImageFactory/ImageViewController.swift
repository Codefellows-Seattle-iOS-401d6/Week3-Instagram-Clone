//
//  ImageViewController.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setupable, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
    @IBOutlet weak var imageView: UIImageView!
    lazy var picker = UIImagePickerController()
    
    //MARK: Setupable Methods
    func setup() {
        self.navigationItem.title = "Image Factory"
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 3.0
    }
    
    //MARK: ViewController Lifecycle
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setup()
        self.setupAppearance()
    }
    
    //MARRK: ActionSheet and Picker Presenting
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source", message: "Please select type source", preferredStyle: .ActionSheet)
        let actionCamera = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        let actionPhotoLibrary = UIAlertAction(title: "Photo Library", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionPhotoLibrary)
        actionSheet.addAction(actionCancel)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        self.picker.delegate = self
        self.picker.sourceType = sourceType
        self.presentViewController(self.picker, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate Methodes
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonSelected(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
}

