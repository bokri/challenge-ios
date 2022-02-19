//
//  BankinApiProtocol.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

protocol BankinApiProtocol {
    static func getBanks(nextUri: String?) -> Single<BanksWrapper>
}
