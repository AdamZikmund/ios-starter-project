import UIKit

import RealmSwift

/// Repositories coordinator
class RepositoriesCoordinator: CoordinatorProtocol {

    // MARK: Properties

    private(set) var navigationController: UINavigationController
    private(set) var childCoordinators: [CoordinatorProtocol] = []

    private(set) var repositoriesController: RepositoriesController

    weak var delegate: RepositoriesCoordinatorDelegate?

    /// Initializes coordinator with navigation controller
    ///
    /// - Parameter navigationController: Navigation controller
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repositoriesController = RepositoriesController.storyboard()!
    }

    /// Starts coordinator flow
    func start() {

        let realm = try? Realm()
        let repository = CachedRepository(moyaRepository: MoyaRepository(),
                                          realmRepository: RealmRepository(realm: realm!))

        repositoriesController.delegate = self
        repositoriesController.viewModel = RepositoriesViewModel(repository: repository)

        if navigationController.topViewController == nil {
            navigationController.setViewControllers([repositoriesController], animated: false)
        } else {
            navigationController.setViewControllers([repositoriesController], animated: true)
        }
    }

    /// Shows repository view controller
    ///
    /// - Parameter repository: Repository
    func showRepository(repository: Repository) {
        let repositoryViewController = RepositoryController.storyboard()!

        repositoryViewController.delegate = self
        repositoryViewController.viewModel = RepositoryViewModel(repository: repository)

        navigationController.showDetailViewController(repositoryViewController, sender: self)
    }

}

// MARK: - RepositoriesControllerDelegate
extension RepositoriesCoordinator: RepositoriesControllerDelegate {

    func didSelectRepository(controller: RepositoriesController, repository: Repository) {
        showRepository(repository: repository)
    }

    func didDismissRepositories(controller: RepositoriesController) {
        delegate?.repositoriesCoordinatorDidFinish(coordinator: self)
    }

}

// MARK: - RepositoryControllerDelegate
extension RepositoriesCoordinator: RepositoryControllerDelegate {

    func didDismissRepository(controller: RepositoryController) {
        navigationController.dismiss(animated: true)
    }

}
