//
//  ModelAdditions.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/21/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit
import CloudKit

enum PostError : ErrorType {
    case WritingImage
    case CreateCKRecord
}

extension Post
{
    class func recordWith(post: Post) throws -> CKRecord?
    {
        let imageURL = NSURL.imageURL() //getting reference to URL, pointer to teh path
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else {throw PostError.WritingImage } // turning the image into data, and if it fails it throws error
        
        let saved = data.writeToURL(imageURL, atomically: true) //it'll save if it didn't fail
        
        if saved
        {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post")
            record.setObject(asset, forKey: "image")
            
            return record
        } else {
            throw PostError.CreateCKRecord
        }
    }
}