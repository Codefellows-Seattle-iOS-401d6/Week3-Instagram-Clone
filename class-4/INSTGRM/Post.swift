//
//  Post.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/21/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

class Post {
    
    var image : UIImage
    
    init(image: UIImage)
    {
    self.image = image  
    }
    
    convenience init()
    {
        self.init(image: UIImage())
    }
}