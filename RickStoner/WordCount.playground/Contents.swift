//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func wordCountForLongString(sentence: String) -> Int {
    var previous: Character?
    var count = 1
    for character in sentence.characters {
        if let previousChar = previous {
            if previousChar != " " && character == " " {
                count += 1
            }
        }
        previous = character
    }
    return count
}


let sentence = "How many   words are in this sentence, answer there are eleven."

let sentenceCount = wordCountForLongString(sentence)
