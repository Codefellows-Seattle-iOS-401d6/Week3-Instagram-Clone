//
//  ViewController.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/20/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//


import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewControllerDelegate, Identity {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
        
        API.shared.GET { (posts) in
            print(posts)
        }
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
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
        
        self.post = Post(image: image)
        self.performSegueWithIdentifier(FiltersPreviewViewController.id(), sender: nil)
//        
//        let actionSheet = UIAlertController(title: "Filters", message: "Please select a filter.", preferredStyle: .ActionSheet)
//    
//        let vintageFilter = UIAlertAction(title: "Vintage", style: .Default) { (action) in Filters.shared.vintage(image) { (theImage) in
//        self.imageView.image = theImage }
//        }
//        let bwFilter = UIAlertAction(title: "Black & White", style: .Default) { (action) in Filters.shared.bw(image) { (theImage) in
//            self.imageView.image = theImage }
//        }
//        let chromeFilter = UIAlertAction(title: "Chrome", style: .Default) { (action) in Filters.shared.chrome(image) { (theImage) in
//            self.imageView.image = theImage }
//        }
//        let processFilter = UIAlertAction(title: "Process", style: .Default) { (action) in Filters.shared.chrome(image) { (theImage) in
//            self.imageView.image = theImage }
//        }
//        let posterizeFilter = UIAlertAction(title: "Posterize", style: .Default) { (action) in Filters.shared.posterize(image) { (theImage) in
//            self.imageView.image = theImage }
//        }
//        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (action) in self.imageView.image = Filters.original }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        actionSheet.addAction(vintageFilter)
//        actionSheet.addAction(bwFilter)
//        actionSheet.addAction(chromeFilter)
//        actionSheet.addAction(processFilter)
//        actionSheet.addAction(posterizeFilter)
//        actionSheet.addAction(resetAction)
//        actionSheet.addAction(cancelAction)
//        self.presentViewController(actionSheet, animated: true, completion: nil)

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
        
        self.post = Post(image: image)
        
        API.shared.POST(self.post) { (success) -> () in //POST was write
            if success {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image), nil)
                print("Yay!")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FiltersPreviewViewController.id()
        {
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
            print("Unsuccessful at retrieving image")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
    extension ImageViewController
    {
     
        
            func imagePickerControllerDidCancel(picker: UIImagePickerController) {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        
            func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
                self.imageView.image = image
                Filters.shared.original = image
                self.dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        self.imageView.image = image
//        Filters.original = image
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//}


