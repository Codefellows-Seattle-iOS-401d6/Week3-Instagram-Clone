//
//  Identity.swift
//  INSTA
//
//  Created by Jessica Malesh on 6/23/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import Foundation

protocol Identity: class  {
    static func id() -> String 
}

extension Identity
{
    static func id() -> String{
        return String(self)
    }
}