enum FileType {
    case image
    case video
    case gif
}

struct Resolution {
    var height = 0
    var width = 0
    
    init(_ w: Int, _ h: Int){
        self.height = h
        self.width = w
    }
}

struct File {
    var resolution: Resolution
    var size: String
    var name: String?
    var type: FileType
    
    func toString() -> String {
        var result = "Type: \(type)"
        if let name = name {
            result += ", Name: \(name)"
        }
        result += ", Size: \(size)"
        result += ", Resolution: \(resolution.width)x\(resolution.height)"
        return result
    }
}

class Post {
    let ID: Int
    var platform: String
    var file: File
    var username: String
    var caption: String
    var likes: String
    var shares: String
    var saves: String
    var views: String
    var comments: [String]
    
    init(_ ID: Int, _ platform: String, _ file: File, _ username: String, _ caption: String, _ likes: String = "0", _ shares: String = "0", _ saves: String = "0", _ views: String = "0", _ comments: [String] = []) {
        self.ID = ID
        self.platform = platform
        self.file = file
        self.username = username
        self.caption = caption
        self.likes = likes
        self.shares = shares
        self.saves = saves
        self.views = views
        self.comments = comments
    }
    
    func toString() -> String {
        return "\(platform) POST {ID: \(ID), Username: \(username), Type of media: \(file.type), caption: \(caption), likes: \(likes), shares: \(shares), saves: \(saves), views: \(views)}"
    }
    
    func adjustInteger(_ value: String, _ what: String) {
        let integer = Int(value) ?? 0
        if integer >= 1000 {
            let suffixes = ["", "k", "M"]
            var num = Double(integer)
            var suffixIndex = 0
            
            while num >= 1000 && suffixIndex < suffixes.count - 1 {
                num /= 1000
                suffixIndex += 1
            }
            
            switch what {
            case "likes":
                self.likes = "\(num)\(suffixes[suffixIndex])"
            case "shares":
                self.shares = "\(num)\(suffixes[suffixIndex])"
            case "saves":
                self.saves = "\(num)\(suffixes[suffixIndex])"
            case "views":
                self.views = "\(num)\(suffixes[suffixIndex])"
            default:
                print("Incorrect variable name")
            }
        }
    }
    
    func readjustAll() {
        adjustInteger(likes, "likes")
        adjustInteger(shares, "shares")
        adjustInteger(saves, "saves")
        adjustInteger(views, "views")
    }
}

class TwitterPost: Post {
    var forwarded: String
    
    override func toString() -> String {
        return "\(platform) POST {ID: \(ID), Username: \(username), Type of media: \(file.type), caption: \(caption), likes: \(likes), shares: \(shares), saves: \(saves), views: \(views), forwarded: \(forwarded)}"
    }
    
    override func readjustAll() {
        super.adjustInteger(super.likes, "likes")
        super.adjustInteger(super.shares, "shares")
        super.adjustInteger(super.saves, "saves")
        super.adjustInteger(super.views, "views")
        adjustInteger(forwarded, "forwarded")
    }
    
    override func adjustInteger(_ value: String, _ what: String) {
        let integer = Int(value) ?? 0
        if integer >= 1000 {
            let suffixes = ["", "k", "M"]
            var num = Double(integer)
            var suffixIndex = 0
            
            while num >= 1000 && suffixIndex < suffixes.count - 1 {
                num /= 1000
                suffixIndex += 1
            }
            
            switch what {
            case "likes":
                self.likes = "\(num)\(suffixes[suffixIndex])"
            case "shares":
                self.shares = "\(num)\(suffixes[suffixIndex])"
            case "saves":
                self.saves = "\(num)\(suffixes[suffixIndex])"
            case "views":
                self.views = "\(num)\(suffixes[suffixIndex])"
            case "forwarded":
                self.forwarded = "\(num)\(suffixes[suffixIndex])"
            default:
                print("Incorrect variable name")
            }
        }
    }
    
    init(_ ID: Int, _ username: String, _ caption: String, _ likes: String = "0", _ shares: String = "0", _ saves: String = "0", _ views: String = "0", _ forwarded: String, _ comments: [String] = [], _ file: File) {
        self.forwarded = forwarded
        super.init(ID, "Twitter", file, username, caption, likes, shares, saves,views, comments)
    }
}

let files: [File] = [
    File(resolution: Resolution(1600, 900), size: "3kB", name: "screenshot-20-03-2024", type: .image),
    File(resolution: Resolution(500, 400), size: "1.75kB", name: "ghsdskj6foscnc233", type: .gif),
    File(resolution: Resolution(1000, 700), size: "978B", name: "huge-duck-image", type: .image),
    File(resolution: Resolution(3840, 2400), size: "5MB", name: "Video-play-2022", type: .video)
]

let posts: [Post] = [
    Post(1, "Instagram", files[3], "user", "holiday's goals", "12000000"),
    TwitterPost(2, "urmomishere", "urmomishere", "123424", "1000", "2923", "123", "425", [], files[0]),
    TwitterPost(3, "Dr Zygmunt", "Jestem lekarzem", "1002", "43", "12", "310000", "10423", [], files[1]),
    TwitterPost(4, "user2", "gg", "52221", "10091", "7323", "3100", "45003", [], files[2])
]

print("POSTS:")
for post in posts {
    post.readjustAll()
    print(post.toString())
}

print("FILES:")
for file in files {
    print(file.toString())
}
