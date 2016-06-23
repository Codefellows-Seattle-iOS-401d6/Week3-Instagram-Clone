//
//  Filters.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/21/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    static let shared = Filters()
    
    static var originalImg = UIImage()
    
    private let context: CIContext
    
    private init()
    {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGLContext, options: options)
    }
    
        
        
        
    private func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        NSOperationQueue().addOperationWithBlock({
            guard let filter = CIFilter(name: name) else {fatalError("Check your spelling")}
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            guard let outputImage = filter.outputImage else {fatalError("Error creating output image")}
            
            let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(theImage: UIImage(CGImage: cgImage))
            })
        })
    }
    
    func vintage(image: UIImage, completion: FiltersCompletion){
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func comic(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIComicEffect", image: image, completion: completion)
    }
    
    func pixelate(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIHexagonalPixelate", image: image, completion: completion)
    }
    
    func sketch(image: UIImage, completion: FiltersCompletion) {
        self.filter("CILineOverlay", image: image, completion: completion)
    }
    
    func bw(image: UIImage, completion: FiltersCompletion){
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image: UIImage, completion: FiltersCompletion){
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
}





















