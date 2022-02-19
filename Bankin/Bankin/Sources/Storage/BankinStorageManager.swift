//
//  BankinStorageManager.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift
import RealmSwift

enum BankinStorageManager: BankinStorageProtocol {

    ///
    /// `getBanks` is a method that listens to any Bank changes and returns a DatabaseToken
    public static func getBanks(completionHandler: @escaping ([Bank]) -> Void) -> DatabaseToken? {
        
        return try? Configuration.getRealm().fetchObjects(type: Bank.self, predicate: nil, orderBy: nil, ascending: false) { changes, results in

            completionHandler(results.filter({ $0.isInvalidated == false }))
        }
    }

    ///
    /// Checks is we have Banks in our local database
    internal static func haveBanks() -> Single<Bool> {
        return Configuration.getSingleRealm()
            .flatMap { realm in
                return realm.getObjects(type: Bank.self, predicate: nil)
                    .map { banks in
                        return banks.isEmpty == false
                    }
            }
    }

    ///
    /// Adds a BanksWrapper in database
    public static func addBanks(wrapper: BanksWrapper) -> Completable {
        return Configuration.getSingleRealm()
            .flatMapCompletable { realm in
                return realm.addArray(data: [wrapper])
            }
    }

    ///
    /// Returns the unique Wrapper in the Database
    public static func getWrapper() -> Single<BanksWrapper?> {
        return Configuration.getSingleRealm()
            .flatMap { realm -> Single<BanksWrapper?> in
                return realm.getObjects(type: BanksWrapper.self,
                                       predicate: nil)
                    .map { banks in
                        return banks.first
                    }
            }
    }
}
