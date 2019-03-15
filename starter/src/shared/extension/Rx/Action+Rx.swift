import RxSwift
import Action

// MARK: - Action
extension Action {

    var underlyingErrors: Observable<Error> {
        return errors
            .map { error in
                switch error {
                case .underlyingError(let error):
                    return error
                default:
                    return nil
                }
            }
            .unwrap()
    }

}
