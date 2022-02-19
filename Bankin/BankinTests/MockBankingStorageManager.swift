//
//  MockBankingStorageManager.swift
//  BankinTests
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift
@testable import Bankin

class MockBankingStorageManager: BankinStorageProtocol {
    
    static var haveBanksValue: Bool = false

    static func getBanks(completionHandler: @escaping ([Bank]) -> Void) -> DatabaseToken? {
        return nil
    }
    
    static func haveBanks() -> Single<Bool> {
        return .just(haveBanksValue)
    }
    
    static func addBanks(wrapper: BanksWrapper) -> Completable {
        return .empty()
    }
    
    static func getWrapper() -> Single<BanksWrapper?> {
        return .just(nil)
    }
}
