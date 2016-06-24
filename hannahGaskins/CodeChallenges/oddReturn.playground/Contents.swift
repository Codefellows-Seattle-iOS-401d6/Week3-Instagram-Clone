// 6.21.2016 

// Write a function that returns all the odd elements of an array

func oddReturn(inputArray: [Int]) -> [Int] {
    var placingArray: [Int] = []
    for number in inputArray {
        if number % 2 != 0 {
            placingArray.append(number)
        }
    }
    return placingArray
}

oddReturn([1, 2, 3, 4, 5, 6])