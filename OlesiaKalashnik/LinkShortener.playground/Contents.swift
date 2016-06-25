//: Playground - noun: a place where people can play

import UIKit

let maxCapacity = 3

class Shortener {
    
    var dict = [Int : String](minimumCapacity: maxCapacity)
    var urlQueue = NSMutableOrderedSet(capacity: maxCapacity)
    
    func encodeURL(url: String) -> Int {
        
        if !urlQueue.containsObject(url) {
            var short = random()
            
            if urlQueue.count < maxCapacity {
                //enqueue and add to dictionary
                urlQueue.addObject(url)
                while dict[short] != nil {
                    short = random()
                }
                dict[short] = url
                return short
                
            } else {

                let firstEl = urlQueue.firstObject as? String
                urlQueue.removeObjectAtIndex(0)
                let shortForURL = (dict as NSDictionary).allKeysForObject(firstEl!).first as? Int
                dict.removeAtIndex(dict.indexForKey(shortForURL!)!)
                
                //enqueue and add to dictionary
                urlQueue.addObject(url)
                while dict[short] != nil {
                    short = random()
                }
                dict[short] = url
                return short
            }
        } else {
            return (dict as NSDictionary).allKeysForObject(url).first as! Int
        }
    }
    
    func decode(short: Int) -> String? {
        return dict[short]
    }
    
    private func random() -> Int {
        return Int(arc4random() % UInt32(100000))
    }
}


//Tests
let shortner = Shortener()
shortner.encodeURL("myURL1")
print("Dict: \(shortner.dict)")
print("Queue: \(shortner.urlQueue)")

shortner.encodeURL("myURL2")
print("Dict: \(shortner.dict)")
print("Queue: \(shortner.urlQueue)")

shortner.encodeURL("myURL3")
print("Dict: \(shortner.dict)")
print("Queue: \(shortner.urlQueue)")

shortner.encodeURL("myURL3")
print("Dict: \(shortner.dict)")
print("Queue: \(shortner.urlQueue)")

let short = shortner.encodeURL("myURL4.com")
print("Dict: \(shortner.dict)")
print("Queue: \(shortner.urlQueue)")

shortner.decode(short)
print(shortner.dict)





