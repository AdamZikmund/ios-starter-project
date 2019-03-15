import RxSwift
import RxCocoa
import Action

/// Repositories view model
class RepositoriesViewModel: ViewModel {

    // MARK: Properties

    private let repository: RepositoryProtocol

    // MARK: Rx

    let repositories: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])

    lazy var fetchAction: Action<Void, [Repository]> = {
        return Action(workFactory: { [unowned self] _ -> Single<[Repository]> in
            let since = self.repositories.value.count

            return self.repository.getAll(since: since)
        })
    }()

    /// Initializes view model with repository protocol
    ///
    /// - Parameter repository: Repository
    init(repository: RepositoryProtocol = MoyaRepository()) {
        self.repository = repository
    }

    override func bind() {
        super.bind()

        fetchAction
            .elements
            .withLatestFrom(repositories, resultSelector: { newRepositories, oldRepositories in
                return oldRepositories + newRepositories
            })
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }

}
