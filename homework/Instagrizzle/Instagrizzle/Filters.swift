//
//  Filters.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/21/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    static var original: UIImage?
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        if original == nil {
            original = image
        }
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("Check your spelling") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            let options = [kCIContextWorkingColorSpace : NSNull()]
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
            
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    class func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func bw(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func sepia(image: UIImage, completion: FiltersCompletion) {
        self.filter("CISepiaTone", image: image, completion: completion)
    }
    
    class func invert(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }

}