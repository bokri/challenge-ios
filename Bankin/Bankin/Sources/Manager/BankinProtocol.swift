//
//  BankinProtocol.swift
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
