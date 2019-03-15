/// Repositories controller delegate
protocol RepositoriesControllerDelegate: class {

    /// Delegates selecting event for repository
    ///
    /// - Parameter repository: Selected repository
    func didSelectRepository(controller: RepositoriesController, repository: Repository)

    /// Delegates dismiss event
    ///
    /// - Parameter controller: Controller which is producing dismiss event
    func didDismissRepositories(controller: RepositoriesController)

}
