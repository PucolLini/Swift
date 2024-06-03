class Database {
    var cities: [String]
    var movies: [String]
    var books: [String]
    
    init() {
        cities = ["Paryż", "Nairobi", "Tokio", "Londyn", "Rzym", "Istanbul",
            "Sydney", "Barcelona", "Mumbai", "Moskwa", "Berlin", "Bangkok", "Hawana",
            "Rio de Janeiro",  "Johannesburg", "Buenos Aires", "Nowy Jork", "Dubaj",
            "Los Angeles", "Singapur", "Pekin", "Toronto", "Kair", "Oslo"]

        movies = ["Matrix", "Titanic", "Incepcja", "Interstellar", "Avatar", "Siedem", 
            "Gladiator", "Avengers", "Złap mnie, jeśli potrafisz", "Życie Pi", "Terminator 2: Dzień sądu", 
            "Gwiezdne wojny: Wojny Klonów", "Skazani na Shawshank", "Forrest Gump", "Pulp Fiction",
            "Szósty zmysł", "Ojciec chrzestny", "Czas Apokalipsy", "Incepcja", "Władca Pierścieni: Drużyna Pierścienia", 
            "Matrix Reloaded", "Gran Torino", "Nietykalni", "Lista Schindlera", "Piękny umysł", "Szeregowiec Ryan", 
            "Szklana pułapka", "Podziemny krąg", "Światła rampy", "Bękarty wojny"]

            
        books = ["Zabić drozda", "Władca Pierścieni", "Harry Potter i Kamień Filozoficzny", "1984",
            "Mały Książę", "Mistrz i Małgorzata", "Duma i uprzedzenie", "Lśnienie", "Złodziejka książek",
            "Wichrowe Wzgórza", "Miecz przeznaczenia", "Czarodziejka z Florencji", "Zmierzch",
            "Hobbit, czyli tam i z powrotem", "Alicja w Krainie Czarów", "Martwe dusze",
            "Ania z Zielonego Wzgórza", "Sagi o Ludziach Lodu", "Wieża Jaskółki", "Miecz przeznaczenia",
            "Sagi o Ludziach Lodu", "Cztery pory roku", "Zabójstwo Rogera Ackroyda", "Małe życie",
            "Wzgórze psów", "Obywatel Kane", "Romeo i Julia", "Książę", "Lalka", "Ogniem i mieczem",
            "Dżuma", "Nostromo", "Lśnienie"]

    }
}

class Game {
    var password: String?
    var guessedLetters: [Character]?
    var passwordLength: Int = 0
    var guesses: Int = 0
    var maximumTries: Int = 34
    var database: Database
    var difficulty: Int = 1
    
    init() {
        self.database = Database()
    }
    
    init(_ password: String, _ tries: Int) {
        self.password = password
        self.passwordLength = password.count
        self.guessedLetters = Array(repeating: "_", count: passwordLength)
        self.maximumTries = tries
        self.database = Database()
    }
    
    func showBoard() {
        if let guessedLetters = guessedLetters {
            for letter in guessedLetters {
                print("\(letter) ", terminator: "")
            }
            print("")
        }
    }
    
    func setPassword(_ newPassword: String?) {
        if let newPassword = newPassword {
            self.password = newPassword
            self.passwordLength = newPassword.count
            self.guessedLetters = Array(repeating: "_", count: passwordLength)
            adjustPassword()
        }
    }
    
    func choosePasswordFromDatabase(_ category: String) {
        switch category {
        case "cities":
            let selectedIdx = Int.random(in: 0..<database.cities.count)
            setPassword(database.cities[selectedIdx])
        case "movies":
            let selectedIdx = Int.random(in: 0..<database.movies.count)
            setPassword(database.movies[selectedIdx])
        case "books":
            let selectedIdx = Int.random(in: 0..<database.books.count)
            setPassword(database.books[selectedIdx])
        default:
            break
        }
    }
    
    func setDifficulty(_ difficulty: String) {
        switch difficulty {
        case "easy":
            self.difficulty = 1
            self.maximumTries = 10
        case "medium":
            self.difficulty = 2
            self.maximumTries = 5
        case "hard":
            self.difficulty = 3
            self.maximumTries = 3
        default:
            break
        }
    }
    
    func isUserGuessCorrect(_ userGuess: Character) -> Bool {
        guard let password = password?.lowercased() else {
            return false
        }
        let lowercaseGuess = userGuess.lowercased().first!
        return password.contains(lowercaseGuess)
    }
    
    func addGuess(_ guess: Character) {
        guard let password = password, var guessedLetters = guessedLetters else {
            return
        }
        let lowercaseGuess = guess.lowercased().first!
        
        for (index, letter) in password.enumerated() {
            if letter.lowercased() == String(lowercaseGuess) {
                guessedLetters[index] = letter
            }
        }
        self.guessedLetters = guessedLetters
    }
    
    func adjustPassword() {
        guard let password = password, var guessedLetters = guessedLetters else {
            return
        }
        for (index, symbol) in password.enumerated() {
            if symbol == " " {
                guessedLetters[index] = symbol
            }
        }
        self.guessedLetters = guessedLetters
    }
    
    func isGameOver() -> Bool {
        if let guessedLetters = guessedLetters {
            return !guessedLetters.contains("_") || guesses >= maximumTries
        }
        return true
    }
    
    func gameLoop() {
        while !isGameOver() {
            showBoard()
            print("Incorrect tries left: \(guesses) out of \(maximumTries)")
            print("Enter your guess: ")
            if let userInput = readLine(), let userGuess = userInput.first {
                if isUserGuessCorrect(userGuess) {
                    addGuess(userGuess)
                }
                else{
                    guesses += 1
                }
            }
        }
        
        showBoard()
        
        if let password = password {
            if guesses >= maximumTries {
                print("YOU LOSE!!! The word was \(password) :(")
            } else {
                print("YOU WIN in \(guesses) guesses!!!")
            }
        }
    }
    
    func printMenuCategory() {
        print("----------")
        print("GUESS GAME")
        print("Choose category:")
        print("1. Cities")
        print("2. Movies")
        print("3. Books")
        print("4. FreeMode")
        print("OR")
        print("0. Exit game")
        print("----------")
    }
    
    func printMenuDifficultyLevels() {
        print("----------")
        print("Choose difficulty:")
        print("1. Easy")
        print("2. Medium")
        print("3. Hard")
        print("----------")
    }
    
    func start() {
        var play = true
        var freemode = false
        
        printMenuCategory()
        
        if let userInput = readLine(), let userPick = Int(userInput) {
            switch userPick {
            case 0:
                play = false
            case 1:
                choosePasswordFromDatabase("cities")
            case 2:
                choosePasswordFromDatabase("movies")
            case 3:
                choosePasswordFromDatabase("books")
            case 4:
                freemode = true
                print("Choose word you want it to be a password: ", terminator: "")
                if let userInput = readLine() {
                    setPassword(userInput)
                }
            default:
                print("Incorrect option - automatically chosen cities")
                choosePasswordFromDatabase("cities")
            }
        }
        
        if !freemode {
            printMenuDifficultyLevels()
            if let userInput = readLine(), let userPick = Int(userInput) {
                switch userPick {
                case 1:
                    setDifficulty("easy")
                case 2:
                    setDifficulty("medium")
                case 3:
                    setDifficulty("hard")
                default:
                    print("Incorrect option - automatically chosen Easy Mode")
                    setDifficulty("easy")
                }
            }
        }
        
        if play {
            gameLoop()
        }
    }
}

let game = Game()
game.start()
