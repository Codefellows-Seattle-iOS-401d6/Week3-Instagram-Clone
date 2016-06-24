
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
    
    
    func shorten(longURL: String) -> String {
        let base64digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%&"
        
        var hashValue = abs(longURL.hashValue)
        
        var output: String = ""
        
        while hashValue > 63 {
            
            let remainder = hashValue % 64
            
            output = String(base64digits[base64digits.startIndex.advancedBy(remainder)]) + output
            
            hashValue = hashValue / 64
        }
        
        output = String(base64digits[base64digits.startIndex.advancedBy(hashValue)]) + output
        
        return output
    }

}

// testing

let 🍱 = ShortURLCache(size: 3)

🍱.writeURL("https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285")

🍱.writeURL("https://www.raywenderlich.com/66584/ios7-ibeacons-tutorial")
🍱.writeURL("https://www.popart.com/our-thinking")
🍱.writeURL("https://www.popart.com/our-thinking")
🍱.writeURL("https://www.popart.com/our-thinking")
🍱.writeURL("https://hannahjgaskins.squarespace.com/config/design/template")
🍱.writeURL("https://www.popart.com/our-thinking")
🍱.writeURL("https://www.popart.com/our-thinking")
🍱.writeURL("https://www.popart.com/our-thinking")
🍱.print()
Swift.print(🍱.read("4AR4cQRlJvK"))

