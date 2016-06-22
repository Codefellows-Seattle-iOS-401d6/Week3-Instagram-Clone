//
//  Filters.swift
//  picster
//
//  Created by Derek Graham on 6/21/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (image: UIImage?)->()

class Filters {
    
    static var original = UIImage()
    
    private class func filter ( name: String, image: UIImage, completion: FiltersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("Spelling error in filter name") }

            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace : NSNull()]
            
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
            
            let cGImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion( image: UIImage(CGImage: cGImage))
            })
        }
    }
    
//    private class func filterWithParams ( name: String, inputParams: [String : AnyObject]?, image: UIImage, completion: FiltersCompletion) {
//        NSOperationQueue().addOperationWithBlock {
//            
//            if inputParams != nil {
//                guard let filter = CIFilter(name: name, withInputParameters: inputParams)
//                else { fatalError("Spelling error in filter name") }
//
//            }
//            
//            
//            let options = [kCIContextWorkingColorSpace : NSNull()]
//            
//            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//            
//            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
//            
//            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
//            
//            let cGImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
//            
//            NSOperationQueue.mainQueue().addOperationWithBlock({
//                completion( image: UIImage(CGImage: cGImage))
//            })
//        }
//    }
    
    class func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func bw(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func process(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectProcess", image: image, completion: completion)
    }
    
    class func instant(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectInstant", image: image, completion: completion)
    }
    
    
    
//    class func torus(image: UIImage, completion: FiltersCompletion) {
//        self.filter("CITorusLensDistortion", image: image, completion: completion)
//    }
    
    class func revert(image: UIImage, completion: FiltersCompletion) {
        completion(image: self.original)
    }
    
    class func original(image: UIImage) {
        self.original = image
    }
}