//
//  Filters.swift
//  INSTA
//
//  Created by Jessica Malesh on 6/21/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> () //completes will all be same so create type alias

class Filters
{
    
    static var original = UIImage() //allows us to revert back to original imaage
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion)
    {
        
        NSOperationQueue().addOperationWithBlock
        {
            guard let filter =  CIFilter(name: name) else { fatalError("Check your spelling") }
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            
            //creating gup using egl
            let options = [kCIContextOutputColorSpace : NSNull()]
            let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
            
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock( {
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
        
        //create individual filter to pass in above
        
        
    class func vintage(image: UIImage, completion: FiltersCompletion)
    {
            
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
        
        
    class func bw(image: UIImage, completion: FiltersCompletion)
    {
        
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    
    class func chrome(image: UIImage, completion: FiltersCompletion)
    {
        
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func instant(image: UIImage, completion: FiltersCompletion)
    {
        
        self.filter("CIPhotoEffectInstant", image: image, completion: completion)
    }
    
    class func noir(image: UIImage, completion: FiltersCompletion)
    {
        
        self.filter("CIPhotoEffectNoir", image: image, completion: completion)
    }


        
}