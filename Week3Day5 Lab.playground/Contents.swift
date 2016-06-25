//: Playground - noun: a place where people can play

import UIKit

/*
 
 6.24.2016 Hannah Gaskins and Derek Graham
 
 
 Challenge: Build a link Shortener Service
 
 */
import UIKit
class ShortURLCache {
    
    // queue as data structure
    private var database: [String : String]
    private var records: [String]
    private let size: Int
    
    required init(size: Int) {
        self.database = Dictionary(minimumCapacity: size)
        self.records = [String]()
        self.size = size
    }
    
    func writeURL(longURL: String) -> () {
        
        if let _ = self.database[self.shorten(longURL)] {
            Swift.print("input collision")
        }
        if let _ = self.read(self.shorten(longURL)) {
            Swift.print("input collision")
        } else {
            self.write(longURL, key: self.shorten(longURL))
        }
        
        //        self.write(longURL, key: self.shorten(longURL))
    }
    
    func write(data: String, key: String) -> () {
        
        if self.records.count < self.size {
            self.database[key] = data
            self.records.append(key)
        } else {
            let start = self.records.removeFirst()
            self.database.removeValueForKey(start)
            self.write(data, key: key)
        }
    }
    
    func read(key: String) -> String? {
        //        Swift.print(self.database[key], self.records.indexOf(key))
        
        if let longURL = self.database[key], index = self.records.indexOf(key) {
            self.records.append(self.records.removeAtIndex(index))
            return longURL
        }
        return nil
    }
    
    func print() {
        for record in self.records {
            Swift.print("http://bit.ly/\(record)", database[record])
        }
    }
    
    
    private func toBase64(input: Int) -> String{
        let base64digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%&"
        var output: String = ""
        var number = input
        while number > 63 {
            let remainder = number % 64
            output = String(base64digits[base64digits.startIndex.advancedBy(remainder)]) + output
            number = number / 64
        }
        
        output = String(base64digits[base64digits.startIndex.advancedBy(number)]) + output
        
        return output
    }
    

    func shorten(longURL: String) -> String {
 
        let hashValue = abs(longURL.hashValue)
        var spread = 1000
        
        let magnitude = String(hashValue).characters.count
        if magnitude / String(self.size).characters.count > 2 {
            var shortHash = hashValue % (self.size * spread)
                while (self.records.indexOf(self.toBase64(shortHash)) > 0 ) && spread > 1 {
//                    Swift.print("Matching Record \(hashValue) \(shortHash) -> \(self.toBase64(shortHash)): \(longURL)")
                    if self.database[self.toBase64(shortHash)] == longURL {
//                        Swift.print("same url, ok to ignore")
                        break
                    }
                    spread -= 1
                    shortHash = hashValue % (self.size * spread)
                }
            return self.toBase64(shortHash)
        } else {
            return self.toBase64(hashValue)
        }


    }

}
// testing
let 🍱 = ShortURLCache(size: 100)
🍱.writeURL("https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285")
🍱.writeURL("https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID286")
🍱.writeURL("https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID287")
🍱.writeURL("https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID288")
🍱.writeURL("https://www.raywenderlich.com/66584/ios7-ibeacons-tutorial")

🍱.writeURL("https://hannahjgaskins.squarespace.com/config/design/template")

🍱.print()

