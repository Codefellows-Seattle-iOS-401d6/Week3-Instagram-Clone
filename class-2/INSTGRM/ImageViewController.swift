//
//  ViewController.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/20/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//


import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }
    
    func setup()
    {
        self.navigationItem.title = "INSTGRM"
    }
    
    func setupAppearance()
    {
        self.imageView.layer.cornerRadius = 3.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func presentActionSheet()
    {
        let actionSheet = UIAlertController(title: "Source", message: "Please select the source type.", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
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
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return } //doesn't allow editing by filter if there is no image
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please select a filter.", preferredStyle: .ActionSheet)
    
        let vintageFilter = UIAlertAction(title: "Vintage", style: .Default) { (action) in Filters.vintage(image) { (theImage) in
        self.imageView.image = theImage }
        }
        let bwFilter = UIAlertAction(title: "Black & White", style: .Default) { (action) in Filters.bw(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let chromeFilter = UIAlertAction(title: "Chrome", style: .Default) { (action) in Filters.chrome(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let processFilter = UIAlertAction(title: "Process", style: .Default) { (action) in Filters.chrome(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let posterizeFilter = UIAlertAction(title: "Posterize", style: .Default) { (action) in Filters.posterize(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (action) in self.imageView.image = Filters.original }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(vintageFilter)
        actionSheet.addAction(bwFilter)
        actionSheet.addAction(chromeFilter)
        actionSheet.addAction(processFilter)
        actionSheet.addAction(posterizeFilter)
        actionSheet.addAction(resetAction)
        actionSheet.addAction(cancelAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)

    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>)
    {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your alter image has been saved to your photos.", preferredStyle: .Alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        }
        else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        API.shared.write(Post(image: image)) { (success) in
            if success {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image), nil)
                print("Yay!")
            }
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        Filters.original = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


