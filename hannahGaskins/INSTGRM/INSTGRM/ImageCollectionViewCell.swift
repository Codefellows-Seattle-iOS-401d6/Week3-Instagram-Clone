//
//  ImageCollectionViewCell.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/22/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var post: Post? {
        didSet {
            self.imageView.image = self.post?.image
        }
    }
    
    class func id() -> String {
        return String(self)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil // sets image off screen to nil, clearing out the image from imageView for new images
    }

}
