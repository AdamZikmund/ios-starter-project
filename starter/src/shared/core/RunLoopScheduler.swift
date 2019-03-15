import RxSwift

/// Scheduler with run loop
class RunLoopScheduler: ImmediateSchedulerType {

    // MARK: Properties

    static let `default`: RunLoopScheduler = RunLoopScheduler(name: "default")
    private let thread: ThreadRunLoop

    // MARK: Initialization

    /// Initializes scheduler with name
    ///
    /// - Parameter name: Scheduler name
    private init(name: String) {
        thread = ThreadRunLoop()
        thread.name = name
        thread.qualityOfService = .background
        thread.start()
    }

    func schedule<StateType>(_ state: StateType,
                             action: @escaping (StateType) -> Disposable) -> Disposable {
        let disposable = SingleAssignmentDisposable()

        thread
            .runLoop?
            .perform {
                disposable
                    .setDisposable(action(state))
        }

        return disposable
    }

}
