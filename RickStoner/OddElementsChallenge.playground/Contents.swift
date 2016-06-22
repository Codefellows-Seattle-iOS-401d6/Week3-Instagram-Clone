//: Playground - noun: a place where people can play

import UIKit

func oddElements<T>(array: [T]) -> [T] {
    var oddElements = [T]()
    
    for index in 0..<array.count {
        if index % 2 != 0 {
            oddElements.append(array[index])
        }
    }
    
    return oddElements
}

let arrayOfInts = [3, 6, 2, 7, 1, 6]
oddElements(arrayOfInts)
let arrayofStrings = ["even", "odd", "even", "odd2", "even", "odd3"]

oddElements(arrayofStrings)