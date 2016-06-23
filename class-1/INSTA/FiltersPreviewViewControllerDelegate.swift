//
//  FiltersPreviewViewControllerDelegate.swift
//  INSTA
//
//  Created by Jessica Malesh on 6/23/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate: class
{
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()
    
}