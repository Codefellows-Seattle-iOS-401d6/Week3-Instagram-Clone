// 6.22.2016

// Write a function that computes the list of the first 100 Fibonacci numbers.


func fibonacci(n: Int) -> [Double] {
    var a: Double = 0
    var b: Double = 1
    var sum: [Double] = []
    
    for _ in 1...n {
        
        let c: Double = a
        a = b
        b = b + c
        
        sum.append(c)
    }
    return sum
}

// 0 1 1 2 3 5 8 13 21

fibonacci(100)