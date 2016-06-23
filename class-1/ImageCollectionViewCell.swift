//
//  ImageCollectionViewCell.swift
//  INSTA
//
//  Created by Jessica Malesh on 6/22/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit


class ImageCollectionViewCell: UICollectionViewCell, Identity
{
    @IBOutlet weak var imageView: UIImageView!
    
    
    var post: Post?
        {
        didSet {
            self.imageView.image = self.post?.image
        }
    }
    
    class func id() -> String?
    {
        return String(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil 
    }
}
