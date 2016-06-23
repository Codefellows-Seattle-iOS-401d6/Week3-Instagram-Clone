//
//  ModelAdditions.swift
//  INSTA
//
//  Created by Jessica Malesh on 6/21/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit
import CloudKit

enum PostError : ErrorType //simple error handler
{
    case WritingImage
    case CreateCKRecord
}


extension Post
{
    
    class func recordWith(post: Post) throws -> CKRecord?
    {
        
        let imageURL = NSURL.imageURL() //reference to doc directory
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.WritingImage } //getting data, throws error if no
        
        let saved = data.writeToURL(imageURL, atomically: true) //flag for is above worked
        
        if saved
        {
            let asset = CKAsset(fileURL: imageURL) //we have our url to device
            let record = CKRecord(recordType: "Post")  // assign class name when pushed to cloud
            record.setObject(asset, forKey: "image") //key-vaule pair - refers to asset
            
            return record
            
        }
            
        else
        { //if our save failed throwing different error
            
            throw PostError.CreateCKRecord
        }
        
    }
    
    
    
    
    
    
}