//
//  post.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/21/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit


class Post {
    var image : UIImage
    
    init(image: UIImage) {
        self.image = image
    } // initializaer that takes in an image
    
    // this creates an empty instance of the image
    convenience init() {
        self.init(image: UIImage())        
    }

}