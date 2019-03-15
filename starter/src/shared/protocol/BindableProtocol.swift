import RxSwift

/// Protocol for binding view models
protocol BindableProtocol: class {

    associatedtype ViewModel

    // MARK: Properties

    var viewModel: ViewModel! { get set }
    var disposeBag: DisposeBag { get set }

    /// Binds new subscribers
    /// Needs to be called in didSet
    func bind()

    /// Unbinds subscribers
    /// Needs to be called in willSet
    func unbind()

}

// MARK: - BindableProtocol
extension BindableProtocol {

    /// Unbinds subscribers
    func unbind() {
        disposeBag = DisposeBag()
    }

}
