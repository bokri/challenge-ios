//
//  Configuration.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

public enum Configuration {
    public static let network = BaseNetwork()
    
    static func getRealm() throws -> StorageProtocol {
        return try StorageHelper.configureDatabase(name: "main")
    }

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
