import UIKit

func fibonacciNumbers(amount: Int) -> [Double] {
    var numbers = [Double](count: amount, repeatedValue: 0.0)
    if amount > 1 {
        numbers[1] = 1
        var inx = 0
        while inx < (amount-2) {
            numbers[inx.successor().successor()] = numbers[inx] + numbers[inx.successor()]
            inx = inx.successor()
        }
    }
    
    return numbers
}

//Test
print(fibonacciNumbers(100))
print(fibonacciNumbers(1))