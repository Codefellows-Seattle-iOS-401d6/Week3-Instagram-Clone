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
    
    static let shared = Filters()
    
    var original = UIImage()
    
    private let context: CIContext
    
    private init() {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGLContext, options: options)
    }
    
    
    
    private func filter(name: String, image: UIImage, completion: FiltersCompletions) {
        
        NSOperationQueue().addOperationWithBlock {
            
            guard let filter = CIFilter(name: name) else {fatalError("Check filter name")}
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image")}
            let cgImage = Filters.shared.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    func original(image: UIImage, completion: FiltersCompletions) {
        completion(theImage: self.original)
    }
    
    func vintage(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func bw(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    func colorInvert(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }
    func motionBlur(image: UIImage, completion: FiltersCompletions) {
        self.filter("CIMotionBlur", image: image, completion: completion)
    }
    
}
