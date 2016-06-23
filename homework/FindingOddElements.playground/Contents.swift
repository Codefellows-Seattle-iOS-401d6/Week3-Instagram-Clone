//: Playground - noun: a place where people can play

import UIKit

func findOddElements (input: [Int]) -> [Int] {
    return input.filter({ (element) -> Bool in
        element % 2 != 0
    })
}

let intArray = [3, 4, 5, 6, 7, 8, 9, 10, 0, 22]

findOddElements(intArray)