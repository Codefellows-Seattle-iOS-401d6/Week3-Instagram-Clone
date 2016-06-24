//
//  CustomCollectionViewLayout.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/22/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    let columns : Int
    let spacing : CGFloat = 1.0
    
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
        self.minimumInteritemSpacing = self.spacing/2
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    var itemWidth : CGFloat {
        let width = UIScreen.mainScreen().bounds.width
        let availableWidth = width - (self.spacing * CGFloat(self.columns))
        return availableWidth/CGFloat(self.columns)
    }

}
