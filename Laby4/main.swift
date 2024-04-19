import Foundation

class City {
    let ID: Int
    var name: String
    var description: String
    var latitude: Float
    var longitude: Float
    var tags: [String]
    var locations: [Location]
    
    init(_ ID: Int, _ name: String, _ description: String, _ latitude: Float, _ longitude: Float, _ tags: [String], _ locations: [Location]){
        self.ID = ID
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.tags = tags
        self.locations = locations
    }
    
    // GETTERS
    func getName() -> String {
        return self.name
    }
    
    func getTags() -> [String] {
        return self.tags
    }
    
    func getLatitude() -> Float {
        return self.latitude
    }
    
    func getLongitude() -> Float {
        return self.longitude
    }
        
    func toString() -> String {
        return "ID: \(self.ID); name: \(self.name); description: \(self.description); latitude: \(self.latitude); longitude: \(self.longitude); tags: \(self.tags)"
    }
    
    func distance(_ city: City) -> Float {
        let xLength = abs(self.getLongitude() - city.getLongitude())
        let yLength = abs(self.getLatitude() - city.getLatitude())
        return sqrt(pow(xLength, 2) + pow(yLength, 2))
    }
    
}

struct Location {
    let id: Int
    let type: String //type (restaurants, pubs, museums, monuments)
    let name: String
    let rating: Int //from 1 to 5 stars
    
    init(_ id: Int, _ type: String, _ name: String, _ rating: Int){
        self.id = id
        self.type = type
        self.name = name
        self.rating = rating
    }
    
    func toString() -> String {
        return "ID: \(self.id); type: \(self.type); name: \(self.name);  rating: \(self.rating))"
    }

}


// CREATE
func createRandomLocation(_ ID: Int) -> Location {
    let allTypes = ["restaurant", "pub", "museum", "monument"]
    let selectedType = allTypes.shuffled().prefix(1).joined()
    
    let locationName = "Location \(ID)"
    
    let rating = Int.random(in: 1...5)

    return Location(ID, selectedType, locationName, rating)
}


func createLocationsForCity() -> [Location] {
    let numberOfLocations = Int.random(in: 1...10)
    var locations: [Location] = []
    
    for i in 1...numberOfLocations{
        locations.append(createRandomLocation(i))
    } 
    
    return locations
}

func createRandomCity(_ ID: Int) -> City {
    let cityName = "City \(ID)"
    let cityDescription = "Description for City \(ID)"
    let latitude = Float.random(in: -90.0...90.0)
    let longitude = Float.random(in: -180.0...180.0)
    
    let allTags = ["seaside", "party", "sport", "music", "nature"]
    let numberOfTags = Int.random(in: 1...allTags.count)
    let selectedTags = allTags.shuffled().prefix(numberOfTags)
    
    let locations = createLocationsForCity()
    
    return City(ID, cityName, cityDescription, latitude, longitude, Array(selectedTags), locations)
}

var cities: [City] = []

for i in 1...20 {
    let city = createRandomCity(i)
    cities.append(city)
}

// SEARCH

func citiesWithName(_ name: String) -> [City] {
    var foundCities: [City] = []
    
    for city in cities {
        if city.getName() == name {
            foundCities.append(city)
        }
    }
    
    return foundCities
}

func citiesWithKeyword(_ key: String) -> [City] {
    var foundCities: [City] = []
    
    for city in cities {
        for tag in city.getTags() {
            if tag == key {
                foundCities.append(city)
                break
            }
        }
    }
    
    return foundCities
}

// DISTANCE
    
func distanceBetweenCities(_ city1: City, _ city2: City) -> Float {
    let xLength = abs(city1.getLongitude() - city2.getLongitude())
    let yLength = abs(city1.getLatitude() - city2.getLatitude())
    return sqrt(pow(xLength, 2) + pow(yLength, 2))
}
    
func distanceBetweenCities(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) -> Float {
    let xLength = abs(x1 - x2)
    let yLength = abs(y1 - y2)
    return sqrt(pow(xLength, 2) + pow(yLength, 2))
}

func closestCity(_ x: Float, _ y: Float) -> City {
    var closestDistance = Float.greatestFiniteMagnitude
    var closestCityAway = cities[0]
    
    for city in cities {
        let distance = distanceBetweenCities(city.getLatitude(), city.getLongitude(), x, y)
        if distance < closestDistance {
            closestDistance = distance
            closestCityAway = city
        }
    }
    
    return closestCityAway
}
    
func farthestCity(_ x: Float, _ y: Float) -> City {
    var farthestDistance: Float = 0
    var farthestCityAway = cities[0]
    
    for city in cities {
        let distance = distanceBetweenCities(city.getLatitude(), city.getLongitude(), x, y)
        if distance > farthestDistance {
            farthestDistance = distance
            farthestCityAway = city
        }
    }
    
    return farthestCityAway
}
    
func closestAndFarthestCities(_ x: Float, _ y: Float) -> (closest: City?, farthest: City?) {
    let closest = closestCity(x, y)
    let farthest = farthestCity(x, y)
    return (closest, farthest)
}

func twoFarthestCities(_ cities: [City]) -> (city1: City?, city2: City?) {
    var farthestDistance: Float = 0
    var startCity: City? = nil
    var endCity: City? = nil
    
    for i in 0..<cities.count {
        for j in i+1..<cities.count {
            let distance = distanceBetweenCities(cities[i], cities[j])
            if distance > farthestDistance {
                farthestDistance = distance
                startCity = cities[i]
                endCity = cities[j]
            }
        }
    }
    
    return (startCity, endCity)
}


//EXTENSION OF DATA MODEL

//ADVANCE SEARCH

func cityWith5StarRating(_ cities: [City]) -> [City] {
    return cities.filter { city in
        return city.locations.contains { $0.type.lowercased() == "restaurant" && $0.rating == 5}
    }
}


func display5StarCities(_ cities: [City]) {
    for city in cities{
        print(city.toString())
        for location in city.locations {
            if location.rating == 5 {
                print("- \(location.toString())")
            }
        }
        print("")
    }
}

func relatedLocationsSortedByRating(_ city: City) -> [Location] {
    return city.locations.sorted(by: { $0.rating > $1.rating })
}

func displayHowMany5StarLocations(_ cities: [City]) {
    var locationsCounter: [Int] = []
    var eachCityLocations: [[Location]] = []
    
    for city in cities {
        var localCityCounter = 0
        var localCityLocations: [Location] = []
        for location in city.locations {
            if location.rating == 5 {
                localCityCounter += 1
                localCityLocations.append(location)
            }
        }
        locationsCounter.append(localCityCounter)
        eachCityLocations.append(localCityLocations)
    }
    
    for i in 0..<cities.count {
        print("City name: \(cities[i].name); 5-star locations: \(locationsCounter[i]); Locations: \(eachCityLocations[i].map { $0.name })")
    }
}


// MAIN
print("ALL CREATED CITIES")

for city in cities {
    print(city.toString())
}

print("")
print("CITIES WITH NAME - 'City 2'")

let resultCitiesWithName = citiesWithName("City 2")

for city in resultCitiesWithName {
    print(city.toString())
}

print("")
print("CITIES WITH TAG - 'seaside'")

let resultCitiesWithTag = citiesWithKeyword("seaside")

for city in resultCitiesWithTag {
    print(city.toString())
}

print("")
print("DISTANCE BETWEEN CITIES - City 1 and City 2")

let resultDistanceBetweenCities = distanceBetweenCities(cities[0], cities[1])
print(resultDistanceBetweenCities)

print("")
print("CLOSEST AND FARTHEST CITIES - coords(70,102)")

let (resultClosestCity, resultFarthestCity) = closestAndFarthestCities(70,102)

if let resultClosestCity = resultClosestCity {
    print(resultClosestCity.toString())
}

if let resultFarthestCity = resultFarthestCity {
    print(resultFarthestCity.toString())
}

print("")
print("TWO FARTHEST CITIES FROM ARRAY")

let (resultFirstCity, resultSecondCity) = twoFarthestCities(cities)

if let resultFirstCity = resultFirstCity {
    print(resultFirstCity.toString())
}

if let resultSecondCity = resultSecondCity {
    print(resultSecondCity.toString())
}

print("")
print("CITIES WITH 5-STAR LOCATIONS")

display5StarCities(cityWith5StarRating(cities))

print("")
print("RELATED LOCATIONS SORTED BY RATING - City 18")

let city = cities[17]
let relatedLocations = relatedLocationsSortedByRating(city)

for location in relatedLocations {
    print(location.toString())
}

print("")
print("NUMBER OF 5-STAR LOCATIONS IN EACH CITY")

displayHowMany5StarLocations(cities)

