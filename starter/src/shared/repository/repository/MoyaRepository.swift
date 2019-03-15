import Moya

import RxSwift

private enum RepositoryService {

    case getAll(since: Int)

}

extension RepositoryService: TargetType {

    var baseURL: URL {
        return Configuration.API_URL
    }

    var path: String {
        switch self {
        case .getAll:
            return "/repositories"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAll:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getAll(let since):
            let parameters = [
                "since": since
            ]

            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return [
            "Authorization": "token fa76fd1f432049cdf4580f8b576ac5660bd63df1"
        ]
    }

}

/// Moya repository for repository protocol
class MoyaRepository: RepositoryProtocol {

    // MARK: Properties

    private let provider: MoyaProvider<RepositoryService> =
        MoyaProvider(manager: DefaultAlamofireManager.sharedManager,
                     plugins: [NetworkActivityPlugin()])

    /// Gets all public repositories using Moya service
    ///
    /// - Parameter since: Repository identifier offset
    /// - Returns: List of repositories
    func getAll(since: Int) -> Single<[Repository]> {
        return provider
            .rx
            .request(.getAll(since: since))
            .map([Repository].self)
            .asObservable()
            .write(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .resolve(MainScheduler.asyncInstance)
            .asSingle()
    }

}
