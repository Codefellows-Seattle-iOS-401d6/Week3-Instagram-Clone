//
//  API.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/21/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import CloudKit
import UIKit

typealias APICompletion = (success: Bool) -> ()

class API {
    // singleton
    static let shared = API()
    
    // container and reference to container
    let container : CKContainer
    let database : CKDatabase
    
    private init() {
    
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    
    }
    
    func write(post: Post, completion: APICompletion) {
        
        do {
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == error {
                        print(error)
                        print("🍊")
                    }
                    if error == nil && record != nil {
                        print(record)
                        completion(success: true)
                    }
                })
            }
        } catch let error { print(error) } // this will print whatever that enum was
        
    }

    func GET(completion: (posts: [Post]?) -> ()) {
        // create query here: 
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        self.database.performQuery(query, inZoneWithID: nil) { (records, error) in
            if let records = records {
                var posts = [Post]()
                
                for record in records {
                    print("this works")
                    guard let asset = record["image"] as? CKAsset else { return }
                    guard let path = asset.fileURL.path else { return }
                    guard let image = UIImage(contentsOfFile: path) else { return }
                    
                     posts.append(Post(image: image))
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    
                    completion(posts:posts)
                    
                })
            }
            completion(posts: nil)
        }
    }
}
