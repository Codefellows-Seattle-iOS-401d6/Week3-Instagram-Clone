//
//  Filters.swift
//  INSTA
//
//  Created by Jess Malesh on 6/21/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters
{
    static let shared = Filters()
    
    private let context: CIContext
    
    private init()
    {
        let options = [kCIContextOutputColorSpace : NSNull()]
        let EAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: EAGContext, options: options)
    }
    
        
    func filter(name: String, image: UIImage, completion: FiltersCompletion)
    {
        
        NSOperationQueue().addOperationWithBlock { 
            guard let filter =  CIFilter(name: name) else { fatalError("Check your spelling") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
            let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock( { () -> Void in
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    var original = UIImage() //allows us to revert back to original imaage
    
    func original(imagge: UIImage, completion: FiltersCompletion)
    {
        completion(theImage: self.original)
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
    
    func instant(image: UIImage, completion: FiltersCompletion)
    {
        
        self.filter("CIPhotoEffectInstant", image: image, completion: completion)
    }
    
    func noir(image: UIImage, completion: FiltersCompletion)
    {
        
        self.filter("CIPhotoEffectNoir", image: image, completion: completion)
    }


        
}