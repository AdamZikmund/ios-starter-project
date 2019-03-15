import RxSwift

/// Repository protocol
protocol RepositoryProtocol {

    /// Gets all public repositories
    ///
    /// - Parameter since: Repository identifier offset
    /// - Returns: List of repositories
    func getAll(since: Int) -> Single<[Repository]>

}
