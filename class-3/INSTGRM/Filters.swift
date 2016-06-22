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
    
    static let shared = Filters()
    
    private let context: CIContext
    
    private init()
    {
        let options = [kCIContextWorkingColorSpace : NSNull()] //boiler plate for image rendering
        let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGContext, options: options)
    }
    
    private func filter(name: String, image: UIImage, completion: FiltersCompletion)
    {
        NSOperationQueue().addOperationWithBlock
            {
                guard let filter = CIFilter(name: name) else { fatalError("Check yo self") }
                
                filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else { fatalError("error creating output image") }
                let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    completion(theImage: UIImage(CGImage: cgImage))
                })
        }
    }
    func vintage(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func bw(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    func chrome(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    func process(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectProcess", image: image, completion: completion)
    }
    func posterize(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorPosterize", image: image, completion: completion)
    }
}
