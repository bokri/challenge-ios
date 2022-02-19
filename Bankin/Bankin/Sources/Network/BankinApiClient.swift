//
//  BankinApiClient.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

enum BankinApiClient: BankinApiProtocol {
    
    public static func getBanks(nextUri: String?) -> Single<BanksWrapper> {
        return Configuration.network
            .request(networkRouter: BankinRouter.getBanks(nextUri: nextUri))
            .responseAsJSON()
            .flatMap { (data) -> Single<BanksWrapper> in
                return data.decode(type: BanksWrapper.self)
            }
    }
}
