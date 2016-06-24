//
//  Additions.swift
//  picster
//
//  Created by Derek Graham on 6/21/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

extension UIImage {
    
    func normalizedImage() -> UIImage {
        
        if (self.imageOrientation == UIImageOrientation.Up) {
            return self;
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.drawInRect(rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
    
    func hasAlpha() -> Bool {
        let alpha = CGImageGetAlphaInfo(self.CGImage)
        let retVal = (alpha == .First || alpha == .Last || alpha == .PremultipliedFirst || alpha == .PremultipliedLast)
        return retVal
    }
    
    
    func normalizedImage1() -> UIImage {
        if (self.imageOrientation == .Up) {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, !self.hasAlpha(), self.scale)
        var rect = CGRectZero
        rect.size = self.size
        self.drawInRect(rect)
        let retVal = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retVal
    }
    
    class func resize(original: UIImage, size: CGSize)-> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
//        original.drawInRect(<#T##rect: CGRect##CGRect#>)
        original.drawInRect(CGRect( x: 0, y: 0, width: size.width, height: size.height))

        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
        
        
        
        
    }
}

extension NSURL {
    static func imageURL() -> NSURL {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError("Error getting documents directory") }
        
        return documentsDirectory.URLByAppendingPathComponent("image")
    }
}