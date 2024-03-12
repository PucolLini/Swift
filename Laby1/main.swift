import Foundation

//zadanie 1.1
var a = 5
var b = 10
print("\(a) + \(b) = \(a+b)")

//zadanie 1.2
var pg = "Gdansk University of Technology"
let nowe_pg = pg.replacingOccurrences(of: "n", with: "⭐️")
print(nowe_pg)

//zadanie 1.3
let imie = "Karina Wołoszyn"
print(String(imie.reversed()))

//zadanie 2.1
for _ in 1...11{
  print("I will pass this course with best mark, because Swift is great!")
}

//zadanie 2.2
var N = 7

for i in 1...N{
  print(i*i)
}

//zadanie 2.3
N = 4
for _ in 1...N{
  for _ in 1...N{
    print("@",terminator:"")
  }
  print("")
}

//zadanie 3.1
var numbers = [5, 10, 20, 15, 80, 13]
var max = numbers[0]

for n in numbers{
  if(max<n){
    max=n
  }
}
print(max)

print(" ")

//zadanie 3.2
for n in numbers.reversed(){
  print(n)
}

//zadanie 3.3
var allNumbers = [10, 20, 10, 11, 13, 20, 10, 30]

var uniqueSet = Set<Int>()
var result = [Int]()

for number in allNumbers {
    if !uniqueSet.contains(number) {
        result.append(number)
        uniqueSet.insert(number)
    }
}

print(result)

//zadanie 4.1
var number = 10
var dividors = Set<Int>()

for i in (1...number/2){
  if(number%i == 0){
    dividors.insert(i)
  }
}
dividors.insert(number)
var sorted = Array(dividors)
sorted.sort()
print(sorted)

//zadanie 5.1
var flights: [[String: String]] = [
    [
        "flightNumber" : "AA8025",
        "destination" : "Copenhagen"
    ],
    [
        "flightNumber" : "BA1442",
        "destination" : "New York"
    ],
    [
        "flightNumber" : "BD6741",
        "destination" : "Barcelona"
    ]
]

var flightNumbers = Array<String>()

for x in flights {
    if let flightNumber = x["flightNumber"] {
        flightNumbers.append(flightNumber)
    }
}

print(flightNumbers)

//zadanie 5.2
var names = ["Hommer", "Lisa", "Bart"]

var fullName = [[String: String]]()

for name in names {
    let person = ["firstName": name, "lastName": "Simpson"]
    fullName.append(person)
}

print(fullName)
