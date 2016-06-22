//
//  Filters.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/21/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters
{
    
    static var original = UIImage()
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion)
    {
        NSOperationQueue().addOperationWithBlock
            {
                guard let filter = CIFilter(name: name) else { fatalError("Check yo self") }
                
                filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
                
                let options = [kCIContextWorkingColorSpace : NSNull()] //boiler plate for image rendering
                let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
                let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
                
                guard let outputImage = filter.outputImage else { fatalError("error creating output image") }
                
                let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    completion(theImage: UIImage(CGImage: cgImage))
                })
        }
    }
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
    class func process(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectProcess", image: image, completion: completion)
    }
    class func posterize(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorPosterize", image: image, completion: completion)
    }
}
