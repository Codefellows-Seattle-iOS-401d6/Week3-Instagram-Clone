//
//  CodeChallenge.swift
//  INSTA
//
//  Created by Jessica Malesh on 6/21/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import Foundation

let myArray = [2, 5, 7, 19, 56, 34, 90, 7]

func isOdd(number: [Int]) -> [Int]
{
    var oddArray = [Int]()
    for num in number
    {
        if num % 2 != 0
        {
            oddArray.append(num)
        }
    }
    
    return oddArray
    
}




