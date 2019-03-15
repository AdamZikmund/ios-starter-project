import RxSwift
import RxCocoa

import RealmSwift

// MARK: - Object
extension Observable where Element: Object {

    /// Writes Realm object
    ///
    /// - Parameter scheduler: Scheduler in which will be Realm write completed
    /// - Returns: Object written in scheduler
    func write(_ scheduler: ImmediateSchedulerType) -> Observable<Element> {
        return subscribeOn(scheduler)
            .map { object in
                let realm = try Realm()

                realm.beginWrite()

                realm.add(object,
                          update: true)

                try realm.commitWrite()

                return object
        }
    }

    /// Resolves Realm object in another scheduler
    ///
    /// - Parameter scheduler: Scheduler in which will be object resolved
    /// - Returns: Resolved object
    func resolve(_ scheduler: ImmediateSchedulerType) -> Observable<Element?> {
        return map(ThreadSafeReference.init)
            .subscribeOn(scheduler)
            .map { reference in
                let realm = try Realm()

                return realm.resolve(reference)
        }
    }

}

// MARK: - Collection<Object>
extension Observable where Element: Collection, Element.Element: Object {

    /// Writes Realm objects
    ///
    /// - Parameter scheduler: Scheduler in which will be Realm write completed
    /// - Returns: Objects written in scheduler
    func write(_ scheduler: ImmediateSchedulerType) -> Observable<Element> {
        return subscribeOn(scheduler)
            .map { objects in
                let realm = try Realm()

                realm.beginWrite()

                realm.add(objects,
                          update: true)

                try realm.commitWrite()

                return objects
        }
    }

    /// Resolves Realm objects in another scheduler
    ///
    /// - Parameter scheduler: Scheduler in which will be objects resolved
    /// - Returns: Resolved objects
    func resolve(_ scheduler: ImmediateSchedulerType) -> Observable<Element> {
        return map { objects in
            objects.map(ThreadSafeReference.init)
        }
            .subscribeOn(scheduler)
            .map { references in
                let realm = try Realm()

                guard let resolved = references
                    .compactMap({ reference in realm.resolve(reference) }) as? Element else {
                        fatalError("Invalid Swift behaviour")
                }

                return resolved
        }
    }

}

// MARK: - RealmCollection
extension Observable where Element: RealmCollection {

    typealias Value = Element.Element

    /// Sorts realm collection
    ///
    /// - Parameters:
    ///   - keyPath: Sorting property key path
    ///   - ascending: Ascending flag
    /// - Returns: Realm results collection of sorted values
    func sort(by keyPath: String, ascending: Bool = true) -> Observable<Results<Value>> {
        return map { collection in
            return collection
                .sorted(byKeyPath: keyPath, ascending: ascending)
        }
    }

    /// Filters realm collection results
    ///
    /// - Parameter predicate: Filter predicate
    /// - Returns: Realm filtered results collection
    func filter(_ predicate: NSPredicate) -> Observable<Results<Value>> {
        return map { collection in
            return collection
                .filter(predicate)
        }
    }

    /// Filters realm collection results
    ///
    /// - Parameters:
    ///   - predicateFormat: Predicate string format
    ///   - args: Predicate arguments
    /// - Returns: Realm filtered results collection
    func filter(_ predicateFormat: String, args: Any...) -> Observable<Results<Value>> {
        return map { collection in
            return collection
                .filter(predicateFormat, args)
        }
    }

    /// Limits realm collection results
    ///
    /// - Parameters:
    ///   - offset: Offset of first element
    ///   - limit: Limit number of elements count
    /// - Returns: Array of picked values
    func limit(offset: Int, limit: Int) -> Observable<[Value]> {
        return map { collection in
            let count = collection.count

            if offset >= count {
                return []
            }

            let max: Int

            if offset + limit > count {
                max = count - 1
            } else {
                max = offset + limit
            }

            var values: [Value] = []

            for (index, value) in collection.lazy.enumerated()
            where index >= offset && index < max {
                values.append(value)
            }

            return values
        }
    }

}
