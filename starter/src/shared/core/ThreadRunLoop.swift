import Foundation

/// Thread with run loop
class ThreadRunLoop: Thread {

    // MARK: Properties

    private(set) var runLoop: RunLoop?
    private let port: Port = Port()

    // MARK: Life cycle

    override func main() {
        super.main()

        runLoop = RunLoop.current
        runLoop?.add(port, forMode: .common)
        runLoop?.run()
    }

}
