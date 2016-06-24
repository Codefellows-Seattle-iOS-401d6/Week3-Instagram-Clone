//
//  API.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/21/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import CloudKit
import UIKit

typealias APICompletion = (success: Bool) -> ()

class API {
    static let shared = API()
    let container : CKContainer
    let database : CKDatabase
    
    private init() {
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func write(post: Post, completion: APICompletion) {
        do {
            if let record = try Post.recordWith(post){
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil {
                        print("Record: \(record)")
                        completion(success: true)
                    }
                })
            }
        } catch let error {print(error)}
    }
    
    func GETPosts(completion: (posts: [Post]?) -> ()) {
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        self.database.performQuery(query, inZoneWithID: nil) { (records, error) in
            if let safeRecords = records {
                var posts = [Post]()
                for rec in safeRecords {
                    guard let asset = rec["image"] as? CKAsset else { return }
                    guard let path = asset.fileURL.path else { return }
                    guard let img = UIImage(contentsOfFile: path) else { return }
                    posts.append(Post(image: img))
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    completion(posts: posts)
                })
            }
            completion(posts: nil)
        }
    }
}
