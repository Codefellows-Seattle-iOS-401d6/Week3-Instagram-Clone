//
//  FiltersPreviewViewControllerDelegate.swift
//  picster
//
//  Created by Derek Graham on 6/23/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import Foundation
import UIKit

protocol FiltersPreviewViewControllerDelegate : class {
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()
}