//
//  ViewController.swift
//  INSTA
//
//  Created by Jess Malesh on 6/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit
import CloudKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var imageView: UIImageView!

    lazy var imagePicker = UIImagePickerController()
    let container = CKContainer.defaultContainer()
    var publicDatabase: CKDatabase?
    var currentRecord: CKRecord?
    var photoURL: NSURL?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
        publicDatabase = container.publicCloudDatabase
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func setup()
    {
        self.navigationItem.title = "ISTGRM"
    }

    
    func setupAppearance()
    {
        //customise rounded corners
        self.imageView.layer.cornerRadius = 3.0
    }
    
    func presentActionSheet()
    {
        let actionSheet = UIAlertController(title: "Source", message: "Please select source type", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        
        let photosAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
        //instanciate image picker
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil) //set delegate type and present image picker
    }
    
    //button selector goes here need to drag and drop
    
    @IBAction func addButtonSelector(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    
    }
    
    
    @IBAction func editButtonSelected(sender: AnyObject)
    {
        
        guard let image = self.imageView.image else { return } //cant edit if no image
        
//        let actionSheet = UIAlertController(title: "filters", message: "Please select filter")
        
        Filters.bw(image) { (theImage) in
            self.imageView.image = theImage
        }
    }
    
    
    
    @IBAction func saveButtonSelected(sender: AnyObject)
    {
        
        guard let image = self.imageView.image else { return }
        
        API.shared.write(Post(image: image)) { (success) in
            if success {
                
                print("Success")
            }
    }
    
    
    }
    
    
    
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    

}

