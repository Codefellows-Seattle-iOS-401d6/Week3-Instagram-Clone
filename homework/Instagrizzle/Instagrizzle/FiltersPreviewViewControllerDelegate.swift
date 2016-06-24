//
//  FiltersPreviewViewControllerDelegate.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/23/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate: class {
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()
}
