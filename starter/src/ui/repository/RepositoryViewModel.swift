import RxSwift
import RxCocoa

// Repository controller view model
class RepositoryViewModel: ViewModel {

    // MARK: Properties

    private let repository: Repository

    // MARK: Rx

    let name: BehaviorRelay<String>
    let url: BehaviorRelay<URL?>

    /// Initalizes view model from repository object
    ///
    /// - Parameter repository: Repository
    init(repository: Repository) {
        self.repository = repository

        name = BehaviorRelay(value: repository.name)
        url = BehaviorRelay(value: URL(string: repository.url))
    }

}
