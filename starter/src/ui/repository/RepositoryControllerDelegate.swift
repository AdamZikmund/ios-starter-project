/// Repository controller delegate
protocol RepositoryControllerDelegate: class {

    /// Delegates dismiss event
    ///
    /// - Parameter controller: Controller which is producing dismiss event
    func didDismissRepository(controller: RepositoryController)

}
