//
//  ImageCollectionViewCell.swift
//  picster
//
//  Created by Derek Graham on 6/22/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // fixme? notes not showing didset
    var post: Post? {
        didSet{
            self.imageView.image = self.post?.image
        }
    }
    
    class func id()-> String
    {
        return String(self)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
