//
//  ImageCollectionViewCell.swift
//  INSTGRM
//
//  Created by Rick  on 6/22/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var post: Post? {
        didSet {
            self.imageView.image = self.post?.image
            self.imageView.layer.cornerRadius = 4.0
            self.imageView.layer.borderWidth = 1.0
        }
    }
    
    class func identifier() -> String {
        return String(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
