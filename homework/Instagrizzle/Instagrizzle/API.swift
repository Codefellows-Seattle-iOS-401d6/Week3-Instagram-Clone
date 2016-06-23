//
//  API.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/21/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import CloudKit
import UIKit


class API {
    static let shared = API()
    
    let container : CKContainer
    let database : CKDatabase
    
    typealias APICompletion = (success: Bool) -> ()
    
    private init() {
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func write(post: Post, completion: APICompletion) {
        do {
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    print("save record completed")
                    if error == nil && record != nil {
                        completion(success: true)
                    } else {
                        print(error)
                        print(record)
                    }
                })
            }
        } catch let error { print(error) }
    }
    
    func GET(completion: (posts: [Post]?) -> ()) {
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        self.database.performQuery(query, inZoneWithID: nil) { (records, error) in
            if let records = records {
                if error != nil {
                    print(error)
                }
                var posts = [Post]()
                for record in records {
                    guard let asset = record["image"] as? CKAsset else { return }
                    guard let path = asset.fileURL.path else { return }
                    guard let image = UIImage(contentsOfFile: path) else { return }
                    posts.append(Post(image: image))
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    completion(posts: posts)
                })
            } else { completion(posts: nil) }
        }
    }
}