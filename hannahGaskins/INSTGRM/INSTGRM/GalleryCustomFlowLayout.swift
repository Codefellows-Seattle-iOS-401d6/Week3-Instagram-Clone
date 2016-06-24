//
//  GalleryCustomFlowLayout.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/22/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout {
    let columns: Int
    let space: CGFloat = 1.0
    
    init(columns: Int = 3) {
        // writing two initializers in one.
        self.columns = columns
        super.init() // gives us all the properties and behavior of UICVFL
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // we inherit a few properites we need to set
        self.minimumLineSpacing = self.space
        self.minimumInteritemSpacing = self.space // space between each item horizontally and vartically 1 pt
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemWidth() * 2) // function to do the math
    }
    
    func itemWidth() -> CGFloat {
        let width = UIScreen.mainScreen().bounds.width // asking screen for the width
        let availableWidth = width - (CGFloat(self.columns) * self.space) // depends on space
        return availableWidth / CGFloat(self.columns)
    }


}
