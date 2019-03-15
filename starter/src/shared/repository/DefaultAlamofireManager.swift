import Alamofire

/// Default alamofire manager
class DefaultAlamofireManager: Alamofire.SessionManager {

    // MARK: Properties

    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default

        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy

        return DefaultAlamofireManager(configuration: configuration)
    }()

}
