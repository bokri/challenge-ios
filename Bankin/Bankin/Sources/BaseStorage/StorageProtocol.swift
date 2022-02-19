//
//  StorageHelper.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift
import RealmSwift

public protocol StorageProtocol {
    func addArray<T: Object>(data: [T]) -> Completable
    func fetchObjects<T: Object>(type: T.Type,
                                 predicate: NSPredicate?,
                                 orderBy: String?,
                                 ascending: Bool?,
                                 completionHandler: @escaping (_ change: DatabaseChanges<DataBaseResults<T>>, _ results: [T]) -> Void) -> DatabaseToken
    func getObjects<T: Object>(type: T.Type, predicate: NSPredicate?) -> Single<[T]>
}

/// Extension methods to StorageProtocol to reuse implementations instead of duplicate code
extension StorageProtocol {
    public func fetchObjects<T: Object>(type: T.Type,
                                 predicate: NSPredicate?,
                                 completionHandler: @escaping (_ change: DatabaseChanges<DataBaseResults<T>>, _ results: [T]) -> Void) -> DatabaseToken {
        return fetchObjects(type: type, predicate: predicate, orderBy: nil, ascending: nil, completionHandler: completionHandler)
    }
}

public typealias DatabaseToken = NotificationToken
public typealias DatabaseChanges = RealmCollectionChange
public typealias DataBaseResults = Results
