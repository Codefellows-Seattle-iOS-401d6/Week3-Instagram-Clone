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
    var originalImg : UIImage?
    
    static let shared = Filters()
    private let context : CIContext
    private init() {
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGLContext, options: options)
    }
    
    //Helper Function
    private func filter(filterName: String, image: UIImage, completion: filtersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            //save original image before any filters are applied
            if self.originalImg == nil {
                self.originalImg = image
            }

            guard let filter = CIFilter(name: filterName) else {fatalError("Check filter name spelling")}
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            if let outputImg = filter.outputImage {
                let cgImage = Filters.shared.context.createCGImage(outputImg, fromRect: outputImg.extent)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    completion(img: UIImage(CGImage: cgImage))
                })
                
            } else {
                print("No output image")
                return
            }
        }
    }
    
    func vintage(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func bw(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    func fade(image : UIImage, completion: filtersCompletion) {
        self.filter("CIPhotoEffectFade", image: image, completion: completion)
    }
    
    func invert(image : UIImage, completion: filtersCompletion) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }

}
