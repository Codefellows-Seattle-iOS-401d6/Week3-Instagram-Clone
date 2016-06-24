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
    
    var original = UIImage?()
    static let shared = Filters()
    
    private var context = CIContext()
    
    private init() {
        
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGLContext, options: options)
    }
    
    private func filter ( name: String, image: UIImage, completion: FiltersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            let image = image.normalizedImage()
            guard let filter = CIFilter(name: name) else { fatalError("Spelling error in filter name") }

            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
            
            let cGImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion( image: UIImage(CGImage: cGImage))
            })
        }
    }
    
    
    func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func bw(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    func process(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectProcess", image: image, completion: completion)
    }
    
    func instant(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectInstant", image: image, completion: completion)
    }
    
    func original(image: UIImage, completion: FiltersCompletion)
    {
        completion(image: self.original)
    }
    
}