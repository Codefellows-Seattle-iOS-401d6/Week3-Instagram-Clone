//
//  Post.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/21/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class Post {
    var image: UIImage
    
    init (image: UIImage) {
        self.image = image
    }
    
    convenience init() {
        self.init(image: UIImage())
    }
}