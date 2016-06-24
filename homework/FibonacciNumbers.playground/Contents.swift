//: Playground - noun: a place where people can play

import UIKit

func findFirstHundredFibonacci() {
    var counter = 0
    var current: Double = 0
    var previous: Double = 1
    var next: Double
    
    while counter <= 99 {
        counter += 1
        next = current + previous
        print(next)
        previous = current
        current = next
    }
}

findFirstHundredFibonacci()
