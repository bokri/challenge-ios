//
//  Realm+Extensions.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RealmSwift
import RxSwift

extension Realm: StorageProtocol {

    public func addArray<T: Object>(data: [T]) -> Completable {
        return Completable.create { completable in
            do {
                try self.write {
                    self.add(data.unFreezeArray(), update: .modified)
                }
                data.unManage()
                completable(.completed)
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }

    /// Fetch objects from Database with notifications
    ///
    /// - Parameter type: Type of Object to fetch
    /// - Parameter predicate: Predicate to filter the result
    /// - Parameter completionHandler: A method that will be executed once a change is occured in Database
    /// - Returns: The database notification token
    public func fetchObjects<T: Object>(type: T.Type,
                                        predicate: NSPredicate? = nil,
                                        orderBy: String?,
                                        ascending: Bool?,
                                        completionHandler: @escaping (_ change: DatabaseChanges<DataBaseResults<T>>, _ results: [T]) -> Void) -> DatabaseToken {
        var results = self.objects(type)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        if let orderBy = orderBy,
            let ascending = ascending {
            results = results.sorted(byKeyPath: orderBy, ascending: ascending)
        }
        let token = results.observe { (change) in
            completionHandler(change, [T](results.freeze()))
        }
        return token
    }

    /// Fetch objects from Database immediately without notifications
    ///
    /// - Parameter type: Type of Object to fetch
    /// - Parameter predicate: A Predicate
    /// - Returns: An array of objects fetched from Database
    public func getObjects<T: Object>(type: T.Type, predicate: NSPredicate?) -> Single<[T]> {
    return Single<[T]>.create(subscribe: { (single) -> Disposable in
        var results = self.objects(type)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        let objects = [T](results.freeze())
        single(.success(objects))
        return Disposables.create()
    })
    }
}
