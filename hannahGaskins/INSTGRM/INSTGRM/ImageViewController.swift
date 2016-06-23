//
//  ImageViewController.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // testing get function - check for case on GET/Get/get
        API.shared.GET { (posts) in
            print(posts)
        }
    }
    
    func setupAppearance() {
        //customize image to have rounded corners
        self.imageView.layer.cornerRadius = 3.0
    }
    
    func setup() {
        self.navigationItem.title = "INSTGRM"
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        // this is interested in the events. sets deleate, sets source type, presents image picker
        // view controller needs to conform to UIImagePickerControllerDelegate and UINavigationControllerDelegate protocols
        self.imagePicker.delegate = self // saying this is the delegate
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func presentActionSheet() {
        // we need to check if user has camera and then present choices for user
        let actionSheet = UIAlertController(title: "Source", message: "select source type", preferredStyle: .ActionSheet)
        
        //now create actions: cameraAction, photoAction, cancelAction
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            // calling imagePicker and calling the source type
            self.presentImagePicker(.Camera)
        }
        
        let photoAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        
        
        
        // action sheet presenting filters options
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please select a filter.", preferredStyle: .ActionSheet)
        
        let bw = UIAlertAction(title: "Black & White", style: .Default) { (action) in
            Filters.shared.bw(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let vintage = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            Filters.shared.vintage(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let chrome = UIAlertAction(title: "Chrome", style: .Default) { (action) in
            Filters.shared.chrome(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let poster = UIAlertAction(title: "Posterize", style: .Default) { (actions) in
            Filters.shared.poster(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let colorNoir = UIAlertAction(title: "Color Noir", style: .Default) { (actions) in
            Filters.shared.colorNoir(image) { (theImage) in
                self.imageView.image = theImage
            }
        }
        
        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (action) in
            self.imageView.image = Filters.original
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        
        
        actionSheet.addAction(bw)
        actionSheet.addAction(vintage)
        actionSheet.addAction(chrome)
        actionSheet.addAction(poster)
        actionSheet.addAction(colorNoir)
        actionSheet.addAction(resetAction)
        actionSheet.addAction(cancelAction)
    
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "saved", message: "Your altered image has been saved to your Photos", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Error saving", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        print("🍋")
        
        // this image is saying i want my image with the filter on it
        guard let image = self.imageView.image else { return }
        
        API.shared.write(Post(image: image)) { (success) in
            
            if success {
                print("🍎")
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image), nil)
                print("yassqween")
            } else {
                print("Nooooooooo!")
            }
        }
    }
    
    
    // now handle image selection - implementing two delegates on imagePicker
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image // passed in as param of delegate function
        Filters.original = image // image reset to original non filtered pix
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

