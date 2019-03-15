import RxSwift
import RxCocoa

import RealmSwift

// MARK: - ReactiveCompatible
extension Realm: ReactiveCompatible { }

// MARK: - Realm
extension Reactive where Base: Realm {

    /// Gets objects from Realm database
    ///
    /// - Parameter type: Type of object
    /// - Returns: Results
    func objects<Element: Object>(_ type: Element.Type) -> Single<Results<Element>> {
        return Single.create(subscribe: { [weak base] single in
            if let realm = base {
                let results = realm.objects(type)
                single(.success(results))
            } else {
                let error = Realm.Error(.fail)
                single(.error(error))
            }

            return Disposables.create()
        })
    }

    /// Gets object for primary key from Realm database
    ///
    /// - Parameters:
    ///   - type: Type of object
    ///   - key: Primary key
    /// - Returns: Object
    func object<Element: Object, KeyType>(ofType type: Element.Type,
                                          forPrimaryKey key: KeyType) -> Single<Element?> {
        return Single.create(subscribe: { [weak base] single in
            if let realm = base {
                let object = realm.object(ofType: type, forPrimaryKey: key)
                single(.success(object))
            } else {
                let error = Realm.Error(.fail)
                single(.error(error))
            }

            return Disposables.create()
        })
    }

}
