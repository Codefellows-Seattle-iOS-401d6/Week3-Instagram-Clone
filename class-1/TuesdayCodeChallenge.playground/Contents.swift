//: Playground - noun: a place where people can play

import UIKit

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

isOdd(myArray)


