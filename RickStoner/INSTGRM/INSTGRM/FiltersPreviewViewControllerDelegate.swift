//
//  FiltersPreviewViewControllerDelegate.swift
//  INSTGRM
//
//  Created by Rick  on 6/23/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit



protocol FiltersPreviewViewControllerDelegate: class {
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()
    
}