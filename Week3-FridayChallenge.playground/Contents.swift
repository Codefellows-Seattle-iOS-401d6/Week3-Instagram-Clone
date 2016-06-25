//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


    func random(longLink: String, length: Int) -> String {
        let base = longLink
        var shortLink: String = ""

        for _ in 0..<length {
            let randomChar = arc4random_uniform(UInt32(base.characters.count))
            shortLink += "\(base[base.startIndex.advancedBy(Int(randomChar))])"
        }
        return shortLink
    }
var links = [String : String]()
func generate(longLink: String) -> String
{
   var count = 0
    
    let shortLink = links[longLink]
    
    if shortLink == nil {
        links[longLink] = random(longLink, length: 6)
        count += 1
    }

    for (key, value) in links
    {
        if longLink == key
        {
            links.removeValueForKey(value)
            links[longLink] = value
            return value
        } else if value == shortLink
        {
            generate(longLink)
        }
    }
    if count >= 100
    {
        links.removeValueForKey(shortLink!)
    }
    print(links)
    return shortLink!
}

generate("www.facebook.com")
generate("www.facebook.com")
generate("www.facebook.com")
generate("www.facebook.com")
generate("www.linkedin.com")
print(links)
