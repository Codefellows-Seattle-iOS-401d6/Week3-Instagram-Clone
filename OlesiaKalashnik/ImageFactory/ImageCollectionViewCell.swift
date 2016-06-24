//
//  ImageCollectionViewCell.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/22/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, Identity {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.setupApperiance()
        }
    }
    
    var post : Post? {
        didSet {
            self.imageView.image = self.post?.image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func setupApperiance() {
        self.imageView?.layer.cornerRadius = 3.0
    }
    
}
