//
//  API.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/21/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import Foundation
import CloudKit

typealias APICompletion = (success: Bool) -> ()

class API
{
    static let shared = API()
    
    let container : CKContainer
    let database: CKDatabase
    
    private init()
    {
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func write(post: Post, completion: APICompletion) //post as an object is posting this to the CK.
    {
        do {
            
            if let record = try Post.recordWith(post)
            {
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil{
                        print(record)
                        completion(success: true)
                    }
                })
            }
            
        } catch let error { print(error) }
    }
}