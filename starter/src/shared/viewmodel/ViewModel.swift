import RxSwift

/// View model base class
class ViewModel {

    // MARK: Properties

    private(set) var disposeBag: DisposeBag = DisposeBag()

    /// Initializes view model with bind call
    init() {
        prepare()
        bind()
        fetch()
    }

    /// Prepares view model Rx properites
    func prepare() { }

    /// Binds actions in view model
    func bind() { }

    /// Fetches view model data
    func fetch() { }

}
