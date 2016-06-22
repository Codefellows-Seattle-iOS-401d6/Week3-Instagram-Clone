//
//  ViewController.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/20/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setup() {
        self.navigationItem.title = "Instagrizzle"
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 3.0
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
        Filters.original = nil
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please select a filter.", preferredStyle: .ActionSheet)
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            Filters.vintage(image, completion: { (theImage) in
                self.imageView.image = theImage
            })
        }
        
        let bwAction = UIAlertAction(title: "Black and White", style: .Default) { (action) in
            Filters.bw(image, completion: { (theImage) in
                self.imageView.image = theImage
            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) in
            Filters.chrome(image, completion: { (theImage) in
                self.imageView.image = theImage
            })
        }
        
        let sepiaAction = UIAlertAction(title: "Sepia", style: .Default) { (action) in
            Filters.sepia(image, completion: { (theImage) in
                self.imageView.image = theImage
            })
        }
        
        let invertAction = UIAlertAction(title: "Invert Color", style: .Default) { (action) in
            Filters.invert(image, completion: { (theImage) in
                self.imageView.image = theImage
            })
        }
        
        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (action) in
            self.imageView.image = Filters.original
        }
        
        actionSheet.addAction(resetAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(bwAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(sepiaAction)
        actionSheet.addAction(invertAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        API.shared.write(Post(image: image)) { (success) in
            
            if success {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                print("No")
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved", message: "Your altered image has been saved to your photos", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save Error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
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



