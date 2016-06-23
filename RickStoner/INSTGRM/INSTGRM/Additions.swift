//
//  Additions.swift
//  INSTGRM
//
//  Created by Rick  on 6/21/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resize(image: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

extension NSURL {
    
    static func imageURL() -> NSURL {
        
        guard let documentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError("Error getting document directory")}
        
        return documentDirectory.URLByAppendingPathComponent("image")
            
    }
}



