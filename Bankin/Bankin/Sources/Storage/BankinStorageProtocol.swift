//
//  BankinStorageProtocol.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

protocol BankinStorageProtocol {
    static func getBanks(completionHandler: @escaping ([Bank]) -> Void) -> DatabaseToken?
    static func haveBanks() -> Single<Bool>
    static func addBanks(wrapper: BanksWrapper) -> Completable
    static func getWrapper() -> Single<BanksWrapper?>
}
