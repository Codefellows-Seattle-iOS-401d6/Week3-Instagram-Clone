//: Playground - noun: a place where people can play

import UIKit

func fibonacci() -> [Double] {
    var fibonacciNumbers = [Double]()
    var result = 0.0
    for number in 0...99 {
        if number > 0 {
            result += fibonacciNumbers[number - 1]
        } else { result = 1.0 }
        fibonacciNumbers.append(result)
    }
    return fibonacciNumbers
}

let numbers = fibonacci()

