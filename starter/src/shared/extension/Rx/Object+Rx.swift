import RealmSwift

import RxSwift

// MARK: - Object
extension Reactive where Base: Object {

    /// Creates thread safe reference to realm object
    ///
    /// - Parameter object: Object
    /// - Returns: Thread safe reference
    private func threadSafeReference(_ object: Base) -> Single<ThreadSafeReference<Base>> {
        return Single<ThreadSafeReference<Base>>
            .create { single in
                let reference = ThreadSafeReference(to: object)

                single(.success(reference))

                return Disposables.create()
        }
    }

    /// Updates realm object
    ///
    /// - Parameter block: Update block
    /// - Returns: Completable
    func update(_ block: @escaping ((Base) -> Void)) -> Completable {
        return threadSafeReference(base)
            .subscribeOn(MainScheduler.asyncInstance)
            .asObservable()
            .flatMap { reference in
                Completable.create { completable in
                    do {
                        let realm = try Realm()

                        guard let resolved = realm.resolve(reference) else {
                            completable(.completed)
                            return Disposables.create()
                        }

                        realm.beginWrite()

                        block(resolved)

                        try realm.commitWrite()
                    } catch let error {
                        completable(.error(error))
                    }

                    return Disposables.create()
                }
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            }
            .asCompletable()
    }

    /// Observes realm object changes
    ///
    /// - Returns: Object
    func observe() -> Observable<Base> {
        return threadSafeReference(base)
            .subscribeOn(MainScheduler.asyncInstance)
            .asObservable()
            .flatMap { reference in
                Observable.create { observer in
                    do {
                        let realm = try Realm()

                        guard let resolved = realm.resolve(reference) else {
                            observer.onCompleted()
                            return Disposables.create()
                        }

                        let token = resolved.observe { changes in
                            switch changes {
                            case .change:
                                observer.onNext(resolved)
                            case .deleted:
                                observer.onCompleted()
                            case .error(let error):
                                observer.onError(error)
                            }
                        }

                        return Disposables.create {
                            token.invalidate()
                        }
                    } catch let error {
                        observer.onError(error)
                        return Disposables.create()
                    }
                }
                    .subscribeOn(RunLoopScheduler.default)
        }
    }

}
