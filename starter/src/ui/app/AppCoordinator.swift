import UIKit

/// Application coordinator
class AppCoordinator: CoordinatorProtocol {

    // MARK: Properties

    private(set) var navigationController: UINavigationController
    private(set) var childCoordinators: [CoordinatorProtocol] = []

    /// Initializes coordinator with navigation controller
    ///
    /// - Parameter navigationController: Navigation controller
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts coordinator flow
    func start() {
        showRepositories()
    }

    /// Shows repositories view controller
    func showRepositories() {
        let repositoriesCoordinator = RepositoriesCoordinator(navigationController: navigationController)

        repositoriesCoordinator.delegate = self
        repositoriesCoordinator.start()

        childCoordinators.append(repositoriesCoordinator)
    }

}

// MARK: - RepositoriesCoordinatorDelegate
extension AppCoordinator: RepositoriesCoordinatorDelegate {

    func repositoriesCoordinatorDidFinish(coordinator: CoordinatorProtocol) {
        childCoordinators
            .removeAll(where: { value in
                value === coordinator
            })
        showRepositories()
    }

}
