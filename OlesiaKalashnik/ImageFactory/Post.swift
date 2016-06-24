//
//  Post.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/21/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class Post {
    var image : UIImage
    init(image: UIImage) {
        self.image = image
    }
    
    convenience init() {
        self.init(image: UIImage())
    }
}