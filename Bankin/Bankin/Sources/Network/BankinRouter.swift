//
//  BankinRouter.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation

import Alamofire

internal enum BankinRouter: NetworkRouter {

    case getBanks(nextUri: String?)

    var endpoint: String {
        return BaseNetworkConstants.apiUrl
    }

    var method: HTTPMethod {
        switch self {
        case .getBanks:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getBanks(let nextUri):
            if let nextUri = nextUri {
                return nextUri
            }
            return "/v2/banks"
        }
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var parameters: Parameters? {
        switch self {
        case .getBanks:
            return nil
        }
    }
}
