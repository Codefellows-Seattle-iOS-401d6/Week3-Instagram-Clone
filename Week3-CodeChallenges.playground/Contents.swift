//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"





//2 write a function that returns an array of odd numbers

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

//3 write a function that returns the first 100 fibonacci numbers.

func fibonacci() -> [Double]
{
    var x = [Double]()
    var num1: Double = 0
    var num2: Double = 1
    x.append(num1)
    x.append(num2)
    
    while x.count < 100
    {
        let sum = num1 + num2
        let new = sum
        x.append(new)
        num1 = num2
        num2 = new
    }
    return x
}

fibonacci()




