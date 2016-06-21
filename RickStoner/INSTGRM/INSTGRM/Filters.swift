//
//  Filters.swift
//  INSTGRM
//
//  Created by Rick  on 6/21/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

typealias FiltersCompletions = (theImage : UIImage) -> ()

class Filters {
    
    static var original = UIImage()
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletions) {
        
        NSOperationQueue().addOperationWithBlock { 
            
            guard let filter = CIFilter(name: name) else {fatalError("Check filter name")}
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            let options = [kCIContextWorkingColorSpace : NSNull()]
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image")}
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    class func vintage(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func bw(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
}
