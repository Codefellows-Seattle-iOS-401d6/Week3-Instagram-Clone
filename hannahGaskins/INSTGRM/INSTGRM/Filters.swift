//
//  Filters.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/21/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    static var original = UIImage()
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("cheek yo spalling") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            // creating GPU Context
            let options = [kCIContextOutputColorSpace : NSNull()]
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            
            // after image has been drawn on the context this data needs to be output somewhere
            // guard let statement insures that the image is drawn on the context
            guard let outputImage = filter.outputImage else { fatalError("error creating output image") }
            
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    
    }
    
    
    // =============================== filters ================================
    
    class func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func bw(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func poster(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIColorPosterize", image: image, completion: completion)
    }
    
    class func colorNoir(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectNoir", image: image, completion: completion)
    }
    
}