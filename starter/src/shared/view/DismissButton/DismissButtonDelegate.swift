import UIKit

/// Dismiss button delegate
protocol DismissButtonDelegate: class {

    /// Delegates dismiss event
    ///
    /// - Parameter button: Dismiss button
    func dismissButtonPressed(button: DismissButton)

}
