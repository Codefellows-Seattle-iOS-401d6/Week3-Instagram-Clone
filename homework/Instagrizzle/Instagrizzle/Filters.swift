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
    var original: UIImage?
    
    static let shared = Filters()
    
    private let context: CIContext
    
    private init() {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGLContext, options: options)
    }
    
    private func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        if Filters.shared.original == nil {
            Filters.shared.original = image
        }
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("Check your spelling") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)

            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }
            
            let cgImage = Filters.shared.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion(theImage: UIImage(CGImage: cgImage))
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
    
    func sepia(image: UIImage, completion: FiltersCompletion) {
        self.filter("CISepiaTone", image: image, completion: completion)
    }
    
    func invert(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }

}