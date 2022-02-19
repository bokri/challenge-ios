//
//  Configuration.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

public enum Configuration {
    // Network client instance
    public static let network = BaseNetwork()
    
    // Realm Database instance
    static func getRealm() throws -> StorageProtocol {
        return try StorageHelper.configureDatabase(name: "main")
    }

    // Realm Database Single instance
    static func getSingleRealm() -> Single<StorageProtocol> {
        return Single<StorageProtocol>.create { single in
            do {
                let realm = try getRealm()
                single(.success(realm))

            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
