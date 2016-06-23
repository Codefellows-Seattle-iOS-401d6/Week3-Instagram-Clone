//
//  ViewController.swift
//  INSTA
//
//  Created by Jess Malesh on 6/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit
import CloudKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerDelegate, Identity
{
    @IBOutlet weak var imageView: UIImageView!

    lazy var imagePicker = UIImagePickerController()
    
    var post = Post()
    
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
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
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
    
    func presentFilterActionSheet()
    {
        guard let image = self.imageView.image else { return } //cant edit if no image
    
        let filterActionSheet = UIAlertController(title: "filters", message: "Please select filter", preferredStyle: .ActionSheet)
        
        let bwAction = UIAlertAction(title: "Black and White", style: .Default) { (action) in
            Filters.shared.bw(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            Filters.shared.vintage(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) in
            Filters.shared.chrome(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let instantAction = UIAlertAction(title: "Instant", style: .Default) { (action) in
            Filters.shared.instant(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let noirAction = UIAlertAction(title: "Noir", style: .Default) { (action) in
            Filters.shared.noir(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let originalAction = UIAlertAction(title: "Original", style: .Default) { (action) in
            Filters.shared.original(image) { (theImage) in
                self.imageView.image = theImage
            }
        }

    
    
        filterActionSheet.addAction(bwAction)
        filterActionSheet.addAction(vintageAction)
        filterActionSheet.addAction(chromeAction)
        filterActionSheet.addAction(instantAction)
        filterActionSheet.addAction(noirAction)
        filterActionSheet.addAction(originalAction)
        
        self.presentViewController(filterActionSheet, animated: true, completion: nil)
    
    }
    
    
    @IBAction func editButtonSelected(sender: AnyObject)
    {
        guard let image = self.imageView.image else { return }
        
        self.post = Post(image: image)
        self.performSegueWithIdentifier(FilterPreviewViewController.id(), sender: nil)
    }
    
    
    
    @IBAction func saveButtonSelected(sender: AnyObject)
    {
        
        guard let image = self.imageView.image else { return }
        
        self.post = Post(image: image)
        API.shared.write(self.post) { (success) -> () in
            if success {
                UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
            }

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == FilterPreviewViewController.id(){
            guard let filterPreviewViewController = segue.destinationViewController as?
                FilterPreviewViewController else { return }
            
            filterPreviewViewController.delegate = self
            filterPreviewViewController.post = self.post
                
                
            }
        }
    func didFinishPickingImage(success: Bool, image: UIImage?) {
        
        if success{
            guard let image = image else { return }
            self.imageView.image = image
        }
        else {
            print("Unsuccessful at retreiving image.")
        }
    }
    
    
    
    
    @IBAction func discardButtonSelected(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
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

