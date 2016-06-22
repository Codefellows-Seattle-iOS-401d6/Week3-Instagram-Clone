//
//  Additions.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/21/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resize(originalImg: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        originalImg.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImg
    }
}

extension NSURL {
    class func getImageURL() -> NSURL {
        if let docsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first {
            return docsDirectory.URLByAppendingPathComponent("image")
        } else {
            fatalError("Could not get documents directory")
        }
    }
}
