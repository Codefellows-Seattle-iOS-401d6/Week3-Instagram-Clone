//: Playground - noun: a place where people can play

import UIKit

//Write a function that returns all the odd elements of an array

func oddElementsIn(array: [Int]) -> [Int] {
    var inx = 0
    var answer = [Int]()
    let arrLength = array.count
    while inx < arrLength {
        if array[inx] % 2 != 0 {
            answer.append(array[inx])
        }
        inx += 1
    }
    return answer
}

//Tests
let arr1 = [0, 6, 4, 5, -9, 77]
oddElementsIn(arr1)
oddElementsIn([Int]())
