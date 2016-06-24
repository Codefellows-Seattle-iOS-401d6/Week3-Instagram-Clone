//: Playground - noun: a place where people can play

import UIKit


var keyArray = [String]()
var database = [String: String]()

func shortenLink (input: String){
    let arr = input.componentsSeparatedByString("/")
    let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let shortenedInput: NSMutableString = NSMutableString(capacity: arr.count)
    
    for _ in 0..<arr.count {
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        shortenedInput.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    database[input] = "bit.ly/" + "\(shortenedInput)"
    
    for (index, key) in keyArray.enumerate() {
        //checking for duplicates
        if input == key {
            print("I'm removing duplicates!")
            keyArray.removeAtIndex(index)
        }
    }
    //making space by deleting oldest one, capacity is at 100
    if keyArray.count >= 5 {
        print("I'm too full!")
        keyArray.removeFirst()
        keyArray.append(input)
    } else {
        print("Everything is G")
        keyArray.append(input)
    }
    
}

shortenLink("http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift")
shortenLink("http://stackoverflow.com/questions/25226940/swift-version-of-componentsseparatedbystring/31906777#31906777")
shortenLink("https://en.wikipedia.org/wiki/Base64")
shortenLink("http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift")
shortenLink("https://codefellows.slack.com/messages/@sungkim03/")
shortenLink("https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UIGestureRecognizer")
shortenLink("https://developer.apple.com/library/ios/documentation/Security/Reference/keychainservices/index.html")

print(keyArray)
print(database)