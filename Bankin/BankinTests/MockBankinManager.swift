//
//  MockBankinManager.swift
//  BankinTests
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
@testable import Bankin

class MockBankinManager: BankinManager {
    override class var storage: BankinStorageProtocol.Type {
        return MockBankingStorageManager.self
    }
    
    override class var apiClient: BankinApiProtocol.Type {
        return MockApiClientManager.self
    }
}
