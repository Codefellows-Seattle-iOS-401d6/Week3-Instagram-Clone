//
//  ImageViewController.swift
//  picster
//
//  Created by Derek Graham on 6/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit
import CloudKit



class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
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
            
            API.shared.write(Post(image: image)) { (success) in
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
        let actionSheet = UIAlertController(title: "Filter", message: "Please choose a filter for your photos", preferredStyle: .ActionSheet)
        
        let bwAction = UIAlertAction(title: "Black & White", style: .Default) { (action) in
            guard let image = self.imageView.image else { return }
            Filters.shared.bw(image, completion: { (image) in
                self.imageView.image = image
            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default ) { (action) in
            guard let image = self.imageView.image else { return }
            Filters.shared.chrome(image, completion: { (image) in
                self.imageView.image = image
            })
        }
        
        let vintageAction = UIAlertAction(title: "Sepia", style: .Default) { (action) in
            guard let image = self.imageView.image else { return }
            Filters.shared.vintage(image, completion: { (image) in
                self.imageView.image = image
            })
        }
        

        let processAction = UIAlertAction(title: "Process", style: .Default ) { (action) in
            guard let image = self.imageView.image else { return }
            Filters.shared.process(image, completion: { (image) in
                self.imageView.image = image
            })
        }
        
        let instantAction = UIAlertAction(title: "Instant", style: .Default) { (action) in
            guard let image = self.imageView.image else { return }
            Filters.shared.instant(image, completion: { (image) in
                self.imageView.image = image
            })
        }
        
        
        let revertAction = UIAlertAction(title: "Revert", style: .Default) { (action) in
            guard let image = Filters.original else { return }
            self.imageView.image = image

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(processAction)
        actionSheet.addAction(instantAction)
        actionSheet.addAction(revertAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        self.imageView.image = image
        Filters.original = image

        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

