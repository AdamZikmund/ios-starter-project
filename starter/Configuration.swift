import Foundation

/// Application configuration
struct Configuration {

    static var API_URL: URL {
        return URL(string: Bundle.main.infoDictionary!["API_URL"] as! String)!
    }

}
