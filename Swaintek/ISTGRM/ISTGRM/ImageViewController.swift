//
//  ViewController.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/20/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    lazy var imagePicker = UIImagePickerController()

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }
    
    func viewWillAppear() {
        super.viewWillAppear(true)
        self.navigationController?.setToolbarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setup()
    {
        self.navigationItem.title = "Dave's Picture Factory"

        self.editButton.enabled = (self.imageView.image != nil)
        self.saveButton.enabled = (self.imageView.image != nil)
    }
    
    func setupAppearance()
    {
        self.imageView.layer.cornerRadius = 3.0
    }
    
    func presentActionsSheet()
    {
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
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addButtonSelected(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionsSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else {return}
        
        let actionSheet = UIAlertController(title: "Filter", message: "Please select the filter type", preferredStyle: .ActionSheet)
        let vintageAction = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            Filters.shared.vintage(image, completion: { (img) in
                self.imageView.image = img
            })
        }
        
        let comicAction = UIAlertAction(title: "Comic", style: .Default) { (action) in
            Filters.shared.comic(image, completion: { (img) in
                self.imageView.image = img
            })
        }
        
        let bwAction = UIAlertAction(title: "Black & White", style: .Default) { (action) in
            Filters.shared.bw(image, completion: { (img) in
                self.imageView.image = img
            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) in
            Filters.shared.chrome(image, completion: { (img) in
                self.imageView.image = img
            })
        }
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(comicAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(bwAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let img = self.imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        
        API.shared.write(Post(image: img)) { (success) in
            if success {
                let alert = UIAlertController(title: "Image saved!", message: nil, preferredStyle: .Alert)
                let excellent = UIAlertAction(title: "Excellent.", style: .Default, handler: { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(excellent)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String :AnyObject]?)
    {
        self.imageView.image = image
        self.editButton.enabled = true
        self.saveButton.enabled = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}






















