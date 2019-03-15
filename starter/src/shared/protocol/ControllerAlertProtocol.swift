import UIKit
import Localize

/// Alert protocol for controllers
protocol ControllerAlertProtocol where Self: UIViewController {

    /// Presents alert for error
    ///
    /// - Parameter error: Error
    func presentAlert(error: Error?)

}

// MARK: - ControllerAlertProtocol
extension ControllerAlertProtocol {

    /// Presents alert for error
    ///
    /// - Parameter error: Error
    func presentAlert(error: Error?) {
        let message: String

        if let error = error {
            message = error.localizedDescription
        } else {
            message = "Unknown error"
        }

        let alertController = UIAlertController(title: "ControllerAlertProtocol.Alert.Title".localized,
                                                message: message,
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "ControllerAlertProtocol.Cancel.Title".localized, style: .cancel)

        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

}
