//
//  ImageViewController.swift
//  picster
//
//  Created by Derek Graham on 6/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit
import CloudKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var post = Post()
    
    
    lazy var imagePicker = UIImagePickerController()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FiltersPreviewViewController.id() {
            guard let filtersPreviewViewController = segue.destinationViewController as? FiltersPreviewViewController else { return }
            filtersPreviewViewController.delegate = self
            filtersPreviewViewController.post = self.post
        }
    }
    
    func didFinishPickingImage(success: Bool, image: UIImage?) {
        if success {
            guard let image = image else { return }
            self.imageView.image = image
            
        } else {
            print("unsucessful at returning image")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        
        let actionSheet = UIAlertController(title: "Save Image", message: "Please choose where to save your photo", preferredStyle: .ActionSheet)
        
        let cloudAction = UIAlertAction(title: "Cloud", style: .Default) { (action) in
            guard let image = self.imageView.image else { return }
            self.post = Post(image: image)
            API.shared.write(self.post) { (success) in
                if success {
                    print("Yay")
                }
            }
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .Default) { (action) in
            //
            guard let image = self.imageView.image else { return }
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cloudAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
         self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        Filters.shared.original = image

        self.post = Post(image: image)
        self.performSegueWithIdentifier(FiltersPreviewViewController.id(), sender: nil)
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        self.imageView.image = image

        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

