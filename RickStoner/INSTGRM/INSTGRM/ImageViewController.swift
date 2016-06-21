//
//  ViewController.swift
//  INSTGRM
//
//  Created by Rick  on 6/20/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit
import CloudKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  Setup {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    
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
    
    @IBAction func originalImageButtonSelected(sender: AnyObject) {
        guard let image = Filters.original else { return }
        self.imageView.image = image
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please select a filter", preferredStyle: .ActionSheet)
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            Filters.vintage(image) { (theImage) in
                self.imageView.image = theImage
                }
        }
        let bwAction = UIAlertAction(title: "Black and White", style: .Default) { (action) in
            Filters.bw(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) in
            Filters.chrome(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        let colorInvertAction = UIAlertAction(title: "Color Invert", style: .Default) { (action) in
            Filters.colorInvert(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        let motionBlurAction = UIAlertAction(title: "Motion Blur (requires patience)", style: .Default) { (action) in
            Filters.motionBlur(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(colorInvertAction)
        actionSheet.addAction(motionBlurAction)
        actionSheet.addAction(vintageAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        
        API.shared.write(Post(image: image)) { (success) in
            if success {
                print("Woohoo!")
            }
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        Filters.original = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

