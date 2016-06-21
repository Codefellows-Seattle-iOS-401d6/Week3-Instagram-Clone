//: Playground - noun: a place where people can play

import UIKit


func wordCount(s: String) -> Int
{
    do {
        let regex = try NSRegularExpression(pattern: "[a-zA-Z]", options: .CaseInsensitive)
        let range = NSRange(location: 0, length: s.characters.count)
        let results = [NSTextCheckingResult] = regex.matchesInString(s, options: .Anchored, range: range)
        
        return results.count
    }

    catch {
        print(error)
}

wordCount("How many words is this")














//var str = "One two three four five, six seven eight Nine ten. Eleven?"
//
//func wordCount(s: String) -> Int
//{
//    let words = s.componentsSeparatedByString(NSRegularExpression(\b))
//    print(words)
//    return words.count
//}
//
//wordCount(str)

