//
//  ModelAdditions.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/21/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import CloudKit
import UIKit

enum PostError : ErrorType {
    case WritingImage
    case CreatingCKRecord
}

extension Post {
    class func recordWith(post: Post) throws -> CKRecord? {
        let imgURL = NSURL.getImageURL()
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.WritingImage }
        let saved = data.writeToURL(imgURL, atomically: true)
        if saved {
            let asset = CKAsset(fileURL: imgURL)
            let record = CKRecord(recordType: "Post")
            record.setObject(asset, forKey: "image")
            return record
        } else {
            throw PostError.CreatingCKRecord
        }
    }
}

