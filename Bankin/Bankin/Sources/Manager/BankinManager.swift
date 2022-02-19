//
//  BankinManager.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

public enum BankinManager {
    
    public static func fetchBanks() -> Completable {
        return BankinStorageManager.haveBanks()
            .flatMapCompletable { haveBanks in
                if haveBanks {
                    return .empty()
                } else {
                    return self.fetchBanksFromApi(nextUri: nil)
                }
            }
    }

    public static func banksDatabaseTokens(completion: @escaping ([Bank]) -> Void) -> DatabaseToken? {
        return BankinStorageManager.getBanks(completionHandler: completion)
    }

    public static func fetchNextPage() -> Completable {
        return BankinStorageManager.getWrapper()
            .flatMapCompletable { wrapper in
                if let nextUri = wrapper?.pagination?.nextUri {
                    return self.fetchBanksFromApi(nextUri: nextUri)
                } else {
                    return .empty()
                }
            }
    }
    
    private static func fetchBanksFromApi(nextUri: String?) -> Completable {
        return BankinApiClient.getBanks(nextUri: nextUri)
            .flatMapCompletable { banksWrapper in
                return BankinStorageManager.addBanks(wrapper: banksWrapper)
            }
    }
}
