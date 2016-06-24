//
//  FiltersPreviewViewControllerDelegate.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/23/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import Foundation
import UIKit

protocol FiltersPreviewViewControllerDelegate: class {
    
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()

}