import RxSwift

/// Cached repository for repository protocol
class CachedRepository: RepositoryProtocol {

    // MARK: Properties

    private let moyaRepository: MoyaRepository
    private let realmRepository: RealmRepository

    // MARK: Initialization

    init(moyaRepository: MoyaRepository, realmRepository: RealmRepository) {
        self.moyaRepository = moyaRepository
        self.realmRepository = realmRepository
    }

    /// Gets all public repositories from cache
    ///
    /// - Parameter since: Repository identifier offset
    /// - Returns: List of repositories
    func getAll(since: Int) -> Single<[Repository]> {
        let moyaSingle = moyaRepository
            .getAll(since: since)
        let realmSingle = realmRepository
            .getAll(since: since)

        return moyaSingle
            .catchError { _ in
                return realmSingle
        }
    }

}
