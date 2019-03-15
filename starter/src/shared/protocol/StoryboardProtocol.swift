import UIKit

/// Protocol for loading view controller from storyboard file
protocol StoryboardProtocol where Self: UIViewController {

    /// Initializes UIViewController from storyboard file
    ///
    /// - Returns: View controller
    static func storyboard() -> Self?

}

// MARK: - StoryboardProtocol
extension StoryboardProtocol {

    /// Default storyboard initialization workflow
    ///
    /// - Returns: View controller
    static func storyboard() -> Self? {
        let name = String(describing: self)
        let bundle = Bundle.main

        let viewController = UIStoryboard(name: name, bundle: bundle)
            .instantiateInitialViewController() as? Self
        viewController?.loadViewIfNeeded()

        return viewController
    }

}
