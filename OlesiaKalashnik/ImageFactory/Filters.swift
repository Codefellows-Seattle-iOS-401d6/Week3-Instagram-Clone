//
//  Filters.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/21/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit
typealias filtersCompletion = (img : UIImage?) -> ()

class Filters {
    static var originalImg : UIImage?
    
    //Helper Function
    private class func filter(filterName: String, image: UIImage, completion: filtersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            //save original image before any filters are applied
            if originalImg == nil {
                originalImg = image
            }
            guard let filter = CIFilter(name: filterName) else {fatalError("Check filter name spelling")}
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            if let outputImg = filter.outputImage {
                let cgImage = gPUContext.createCGImage(outputImg, fromRect: outputImg.extent)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    completion(img: UIImage(CGImage: cgImage))
                })
                
            } else {
                print("No output image")
                return
            }
        }
    }
    
    class func vintage(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func bw(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func fade(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectFade", image: image, completion: completion)
    }
    
    class func invert(image : UIImage, completion: filtersCompletion) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }

}
