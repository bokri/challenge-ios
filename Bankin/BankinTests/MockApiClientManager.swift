//
//  MockApiClientManager.swift
//  BankinTests
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift
@testable import Bankin

class MockApiClientManager: BankinApiProtocol {

    static func getBanks(nextUri: String?) -> Single<BanksWrapper> {
        .error(NetworkError.networkError)
    }
}
