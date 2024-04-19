import Foundation


//zadanie 1 - Functions
print("\nzadanie 1 - Functions\n")

func minValue (a: Int, b: Int) -> Int {
  if a<=b {
    return a
  }
  return b
}

func lastDigit (_ number: Int) -> Int {
    let result = abs(number) % 10
    return result
}

func divides (_ a: Int, _ b: Int) -> Bool {
    if b == 0 {
        return false
    }
    if abs(a) % abs(b) == 0 {
        return true
    }
    return false
}


func countDivisors (_ number: Int) -> Int {
    var counter = 0
    for i in 1...abs(number) {
        if divides(number, i){
            counter+=1
        }
    }
    return counter
}

func isPrime (_ number: Int) -> Bool {
    if number <= 2 {
        return false
    }
    if countDivisors(number) > 2 {
        return false
    }
    return true
}


print(divides(7, 3)) // false - 7 is not divisible by 3
print(divides(8, 4))// true - 8 is divisible by 4
print(countDivisors(1)) // 1 - 1
print(countDivisors(12))// 6 - 1, 2, 3, 4, 6 and 12
print(isPrime(3)) // true
print(isPrime(8)) // false

//zadanie 2 - Closures
print("\nzadanie 2 - Closures\n")

//2.1
//funkcja
func smartBart (_ n: Int, _ closure: () -> Void) {
    for _ in 1...n{
        closure()
    }
}

// sprecyzowanie closure
let phrase = {
    print("I will pass this course with best mark, because Swift is great!")
}

//wywolanie funkcji
smartBart(10, phrase)

//2.2
// tablica
let numbers2 = [10, 16, 18, 30, 38, 40, 44, 50]

// przefiltrowanie tablicy - każdy element musi byc podzielny przez 4
let filteredArray = numbers2.filter{$0 % 4 == 0}

print(filteredArray)

//2.3
let maxValue = numbers2.reduce(0, {
    max($0, $1)
})

print(maxValue)

//2.4
var strings = ["Gdansk", "University", "of", "Technology"]

var joinedStrings = strings.reduce("", {
    $0.isEmpty ? $1 : $0 + " " + $1
})

print(joinedStrings)

//2.5

let numbers5 = [1, 2, 3, 4, 5, 6]

// filter - tylko nieparzyste liczby
let oddNumbers = numbers5.filter{ $0 % 2 != 0 }

// map  - zrobic kwadraty liczb
let squareNumbers = oddNumbers.map { $0 * $0 }

// reduce - suma kwadratow
let sumSquares = squareNumbers.reduce(0) {
    $0 + $1
}

print(numbers5)
print(oddNumbers)
print(squareNumbers)
print(sumSquares)

//zadanie 3  - Tuples
print("\nzadanie 3  - Tuples\n")
//3.1

func minmax (_ a: Int, _ b: Int) -> (min: Int, max: Int) {
    return (min: min(a,b), max: max(a,b))  
}

let minmaxValue = minmax(10, 5)

print(minmaxValue)

//3.2

var stringsArray = ["gdansk", "university", "gdansk", "university", "university", "of", "technology", "technology", "gdansk", "gdansk"]

//stworzenie Tuple
var countedStrings = [String: Int] ()

func countOccurence (_ string: String) -> (Int) {
    var counter = 0
    
    for element in stringsArray {
        if string == element{
            counter += 1
        }
    }
        
    return counter
}


for string in stringsArray {
    countedStrings[string, default: 0] = countOccurence(string)
}

print(countedStrings)

//zadanie 4 - Enums
print("\nzadanie 4 - Enums\n")

//4.1

enum Day: Int {
    case Monday = 1
    case Tuesday
    case Wednesday 
    case Thursday 
    case Friday
    case Saturday 
    case Sunday
    
    func emoji () -> (String){
        switch self {
            case .Monday:
                return "💀"
            case .Tuesday:
                return "💅"
            case .Wednesday:
                return "🐸"
            case .Thursday:
                return "🏃️"
            case .Friday:
                return "💪"
            case .Saturday:
                return "😎"
            case .Sunday:
                return "⭐"
        }
    }
}

let day = Day.Wednesday
print(day.emoji())

