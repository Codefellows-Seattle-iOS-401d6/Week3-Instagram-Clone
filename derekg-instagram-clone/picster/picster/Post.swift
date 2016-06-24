//
//  Post.swift
//  picster
//
//  Created by Derek Graham on 6/21/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class Post {
    var image: UIImage
    init(image: UIImage)
    {
        self.image = image
    }
    
    convenience init(){
        self.init(image: UIImage())
    }
}

