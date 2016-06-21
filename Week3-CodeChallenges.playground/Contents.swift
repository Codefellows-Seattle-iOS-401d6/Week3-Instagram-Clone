//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var myArray = [1,2,3,4,5,6,7,22,44,422,643,67573,317,70,88,999]

func returnOdd(array: [Int] ) -> [Int]
{
    var listOfNumbers = [Int]()
    
    for number in array {
        if number % 2 != 0 {
        listOfNumbers.append(number)
        }
    }
    return listOfNumbers
}

returnOdd(myArray)
