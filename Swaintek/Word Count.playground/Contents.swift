//: Playground - noun: a place where people can play

import UIKit

var str = "One two three four five, six seven eight Nine ten. Eleven?"

func wordCount(s: String) -> Int
{
    let words = s.componentsSeparatedByString(NSRegularExpression(\b))
    print(words)
    return words.count
}

wordCount(str)

