//: Playground - noun: a place where people can play

import UIKit

func listMatches(inString string: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: "\\w+", options: NSRegularExpressionOptions.CaseInsensitive)
        let range = NSRange(location: 0, length: string.utf16.count)
        let matches = regex.matchesInString(string, options: [], range: range)
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substringWithRange(range)
        }
    }
    catch {
        print("Invalid regex")
    }
    return []
}


func countWordsInSentence(sentence: String) -> Int {
    if !sentence.isEmpty && sentence[sentence.endIndex.predecessor()] == "." {
        return listMatches(inString: sentence).count
    }
    print("Invalid sentence.")
    return 0
}

//Tests
let sent1 = "   space   triplespace ."
let sent2 = "."
let sent3 = "Sentence."
let sent4 = "Longer sentence."
let sent5 = ""
countWordsInSentence(sent1)
countWordsInSentence(sent2)
countWordsInSentence(sent3)
countWordsInSentence(sent4)
countWordsInSentence(sent5)







