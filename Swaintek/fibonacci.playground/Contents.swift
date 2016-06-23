//: Playground - noun: a place where people can play

import UIKit

var fibonacci100: [Double] = [0, 1]
var i = 0

while (i < 98) {
    var fibAdd = fibonacci100[i] + fibonacci100[i+1]
    fibonacci100.append(fibAdd)
    i += 1
}

print(fibonacci100)

fibonacci100.count