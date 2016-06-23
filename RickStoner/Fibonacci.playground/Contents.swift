//: Playground - noun: a place where people can play

import UIKit

func fibonacci() -> [Double] {
    var fibonacciNumbers = [Double]()
    var result = 0.0
    for number in 0...99 {
        if number > 1 {
            result += fibonacciNumbers[number - 2]
            fibonacciNumbers.append(result)
        } else {
            fibonacciNumbers.append(result)
            result += 1
        }
    }
    return fibonacciNumbers
}

let numbers = fibonacci()

