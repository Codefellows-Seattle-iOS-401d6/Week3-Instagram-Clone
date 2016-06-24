//: Playground - noun: a place where people can play

import UIKit

//Write a function that determines how many words there are in a sentence

func separateString (input: String) -> Int {
    return input.componentsSeparatedByString(" ").count
}


let testString = "Hello, my name is Sung. I am trying to count how many words there are in this sentence. I hope there are more than 0"

separateString(testString)

