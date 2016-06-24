//
//  ImageViewController.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit
import AssetsLibrary

class ImageViewController: UIViewController, Setupable, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    lazy var picker = UIImagePickerController()
    var post = Post()
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //MARK: Setupable Methods
    func setup() {
        self.navigationItem.title = "Image Factory"
        self.editButton.enabled = (self.imageView.image != nil )
        self.saveButton.enabled = (self.imageView.image != nil )
        self.spinner.stopAnimating()
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 3.0
        self.navigationController?.setToolbarHidden(false, animated: true)
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
        self.editButton.enabled = true
        self.saveButton.enabled = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: @IBActions
    @IBAction func addButtonSelected(sender: UIBarButtonItem) {
        //Filters.shared.originalImg = UIImage()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(sender: UIBarButtonItem) {
        guard let selectedImage = self.imageView.image else { return }
        Filters.shared.originalImg = selectedImage
        self.post = Post(image: selectedImage)
        self.performSegueWithIdentifier("FiltersPreviewViewController", sender: sender)
    }
    
    @IBAction func saveButtonSelected(sender: UIBarButtonItem) {
        guard let img = self.imageView.image else { return }
        //save to camera roll
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        self.spinner.startAnimating()
        
        //save to iCloud
        self.post = Post(image: img)
        API.shared.write(self.post) { (success) in
            if success {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    let alert = UIAlertController(title: "Photo was saved", message: nil, preferredStyle: .Alert)
                    let actionOK = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                    alert.addAction(actionOK)
                    self.spinner.stopAnimating()
                    self.presentViewController(alert, animated: true, completion: nil)
                    print("Record was saved successfully")
                })
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FiltersPreviewViewController.id() {
            guard let filtersPreviewVC = segue.destinationViewController as? FiltersPreviewViewController else {return}
            filtersPreviewVC.delegate = self
            filtersPreviewVC.post = self.post
        }
    }
    
}

extension ImageViewController : FiltersPreviewViewControllerDelegate {
    func didFinishPickingImage(success: Bool, selectedImage: UIImage?) {
        if success {
            guard let img = selectedImage else { return }
            self.imageView.image = img
        } else {
            print("Unsuccessful at retreiving image")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

