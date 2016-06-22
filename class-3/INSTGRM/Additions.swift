//
//  Additions.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/21/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

extension UIImage {
    class func resize(image: UIImage, size: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(size)
        
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

extension NSURL {
    
    static func imageURL() -> NSURL
    {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else {
            fatalError("error.")
        }
        return documentsDirectory.URLByAppendingPathComponent("image")
    }
    
}