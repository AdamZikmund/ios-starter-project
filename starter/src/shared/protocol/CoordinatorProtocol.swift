import UIKit

/// Default coordinator protocol
protocol CoordinatorProtocol: class {

    // MARK: Properties

    var navigationController: UINavigationController { get }
    var childCoordinators: [CoordinatorProtocol] { get }

    // MARK: Initialization

    /// Initalizes coordinator with navigation controller
    ///
    /// - Parameter navigationController: Navigation controller
    init(navigationController: UINavigationController)

    /// Starts coordinator flow
    func start()

    /// Removes coordinator from coordinators array
    ///
    /// - Parameters:
    ///   - coordinator: Removed coordinator
    ///   - coordinators: Array of coordinators
    func removeCoordinator(_ coordinator: CoordinatorProtocol,
                           from coordinators: inout [CoordinatorProtocol])

}

// MARK: - CoordinatorProtocol
extension CoordinatorProtocol {

    /// Removes coordinator from coordinators array
    ///
    /// - Parameters:
    ///   - coordinator: Removed coordinator
    ///   - coordinators: Array of coordinators
    func removeCoordinator(_ coordinator: CoordinatorProtocol,
                           from coordinators: inout [CoordinatorProtocol]) {
        coordinators
            .removeAll(where: { value in
                value === coordinator
            })
    }

}
