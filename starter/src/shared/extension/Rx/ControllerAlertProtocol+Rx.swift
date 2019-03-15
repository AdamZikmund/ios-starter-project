import RxSwift
import RxCocoa

// MARK: - ControllerAlertProtocol
extension Reactive where Base: ControllerAlertProtocol {

    var error: Binder<Error?> {
        return Binder(base, binding: { viewController, error in
            viewController.presentAlert(error: error)
        })
    }

}
