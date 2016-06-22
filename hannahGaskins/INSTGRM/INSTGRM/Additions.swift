//
//  Additions.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/21/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
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
        guard let documentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: . UserDomainMask).first else {
            fatalError("error getting docs Directory")
        }
        return documentDirectory.URLByAppendingPathComponent("image")

    }
}