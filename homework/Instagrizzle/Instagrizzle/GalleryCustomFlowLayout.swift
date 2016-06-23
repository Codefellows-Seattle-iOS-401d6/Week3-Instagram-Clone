//
//  GalleryCustomFlowLayout.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/22/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout {
    let columns: Int
    let spacing: CGFloat = 2.0
    
    init(columns: Int = 3) {
        self.columns = columns
        super.init()
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.minimumLineSpacing = self.spacing
        self.minimumInteritemSpacing = self.spacing
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemWidth())
    }
    
    func itemWidth() -> CGFloat {
        let width = UIScreen.mainScreen().bounds.width
        let availableWidth = width - (CGFloat(self.columns) * self.spacing)
        return availableWidth / CGFloat(self.columns)
    }
}
