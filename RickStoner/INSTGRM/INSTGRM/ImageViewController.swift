//
//  ViewController.swift
//  INSTGRM
//
//  Created by Rick  on 6/20/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit
import CloudKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerDelegate, Setup {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    var post = Post()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        self.navigationItem.title = "INSTGRM - A cheap clone of Instagram"
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 10.0
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source", message: "Please select the source type", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
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
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }

    @IBAction func addButtonSelected(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            presentActionSheet()
        } else {
            presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        Filters.shared.original = image
        self.post = Post(image: image)
        self.performSegueWithIdentifier(FiltersPreviewViewController.identifier(), sender: nil)
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        self.post = Post(image: image)
        
        API.shared.write(self.post) { (success) in
            if success {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FiltersPreviewViewController.identifier() {
            guard let filtersPreviewViewController = segue.destinationViewController as?
                FiltersPreviewViewController else { return }
            filtersPreviewViewController.delegate = self
            filtersPreviewViewController.post = self.post
        }
    }
    
    func didFinishPickingImage(success: Bool, image: UIImage?) {
        if success {
            guard let image = image else { return }
            self.imageView.image = image
        } else {
            print("Unsuccessful retrieval of image")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

