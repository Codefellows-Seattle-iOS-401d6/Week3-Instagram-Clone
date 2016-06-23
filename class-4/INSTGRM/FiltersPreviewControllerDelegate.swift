//
//  FiltersPreviewControllerDelegate.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/23/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

protocol FiltersPreviewControllerDelegate: class
{
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()
}