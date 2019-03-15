import RxSwift

import RealmSwift

/// Realm repository for repository protocol
class RealmRepository: RepositoryProtocol {

    // MARK: Properties

    private let realm: Realm

    // MARK: Initialization

    init(realm: Realm) {
        self.realm = realm
    }

    /// Gets all public repositories from Realm database
    ///
    /// - Parameter since: Repository identifier offset
    /// - Returns: List of repositories
    func getAll(since: Int) -> Single<[Repository]> {
        return realm
            .rx
            .objects(Repository.self)
            .map { results in
                let range = since..<since + 25

                if range.upperBound <= results.count {
                    return Array(results[range])
                } else {
                    return Array(results[since..<results.count])
                }
        }
    }

}
