//
//  Post.swift
//  INSTGRM
//
//  Created by Rick  on 6/21/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class Post {
    
    let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    convenience init() {
        self.init(image: UIImage())
    }
}
