/// Repositories coordinator delegate
protocol RepositoriesCoordinatorDelegate: class {

    /// Delegates finish event
    ///
    /// - Parameter coordinator: Coordinator which is producing finish event
    func repositoriesCoordinatorDidFinish(coordinator: CoordinatorProtocol)

}
