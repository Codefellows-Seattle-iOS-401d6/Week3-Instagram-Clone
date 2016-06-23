//: Playground - noun: a place where people can play

import UIKit


//class Node<T>
//{
//    let data: T
//    var prev: Node<T>?
//    var next: Node<T>?
//    
//    init(data: T)
//    {
//        self.data = data
//    }
//}

class Fibonacci<Int>
{
    var head = 1
    var count = 0
    var ints = [Int]()
    
    init()
    {
        self.head = head
        
    }
    
    func add(data: Int)
    {
        var current = self.head
        
        while count < 100 {
            current = current.next!
            next = current.prev
            let new = current + next
            
            count += 1
        }
        
    }
    return ints
}