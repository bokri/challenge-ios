//
//  BankinManager.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

protocol BankinProtocol {
    static func fetchBanks() -> Completable
    static func banksDatabaseTokens(completion: @escaping ([Bank]) -> Void) -> DatabaseToken?
    static func fetchNextPage() -> Completable
    static func fetchBanksFromApi(nextUri: String?) -> Completable
}

class BankinManager: BankinProtocol {

    class var storage: BankinStorageProtocol.Type {
        return BankinStorageManager.self
    }

    class var apiClient: BankinApiProtocol.Type {
        return BankinApiClient.self
    }
    
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

    public static func banksDatabaseTokens(completion: @escaping ([Bank]) -> Void) -> DatabaseToken? {
        return storage.getBanks(completionHandler: completion)
    }

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
    
    internal static func fetchBanksFromApi(nextUri: String?) -> Completable {
        return apiClient.getBanks(nextUri: nextUri)
            .flatMapCompletable { banksWrapper in
                return storage.addBanks(wrapper: banksWrapper)
            }
    }
}
