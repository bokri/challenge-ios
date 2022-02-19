//
//  BankinManager.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

class BankinManager: BankinProtocol {
    
    // MARK: - Properties

    class var storage: BankinStorageProtocol.Type {
        return BankinStorageManager.self
    }

    class var apiClient: BankinApiProtocol.Type {
        return BankinApiClient.self
    }

    // MARK: - Methods
    
    ///
    /// `fetchBanks` checks if we have banks in local databse otherwise it makes an api call and saves data in local DB
    /// - Returns: Completable
    public static func fetchBanks() -> Completable {
        return storage.haveBanks()
            .flatMapCompletable { haveBanks in
                if haveBanks {
                    return .empty()
                } else {
                    return self.fetchBanksFromApi(nextUri: nil)
                }
            }
    }

    ///
    /// `banksDatabaseTokens` listens to Bank changes in DB
    /// - Returns: DatabaseToken
    public static func banksDatabaseTokens(completion: @escaping ([Bank]) -> Void) -> DatabaseToken? {
        return storage.getBanks(completionHandler: completion)
    }

    ///
    /// `fetchNextPage` checks if nextUri is available then calls it
    /// - Returns: Completable
    public static func fetchNextPage() -> Completable {
        return storage.getWrapper()
            .flatMapCompletable { wrapper in
                if let nextUri = wrapper?.pagination?.nextUri {
                    return self.fetchBanksFromApi(nextUri: nextUri)
                } else {
                    return .empty()
                }
            }
    }
    
    ///
    /// `fetchBanksFromApi` calls getBanks from URL then adds banks to local DB
    /// - Returns: Completable
    internal static func fetchBanksFromApi(nextUri: String?) -> Completable {
        return apiClient.getBanks(nextUri: nextUri)
            .flatMapCompletable { banksWrapper in
                return storage.addBanks(wrapper: banksWrapper)
            }
    }
}
