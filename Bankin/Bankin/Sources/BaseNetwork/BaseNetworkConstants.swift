//
//  BaseNetworkConstants.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation

internal struct BaseNetworkConstants {
    internal static let timeout = 60.0

    internal static let networkBridgeVersion: String = "2021-06-01"
    internal static let clientId: String = "dd6696c38b5148059ad9dedb408d6c84"
    internal static let clientSecret: String = "56uolm946ktmLTqNMIvfMth4kdiHpiQ5Yo8lT4AFR0aLRZxkxQWaGhLDHXeda6DZ"
    
    internal static let apiUrl: String = "https://api.bridgeapi.io"

    // Header's constants
    internal struct HeaderKeys {
        static let clientId = "Client-Id"
        static let clientSecret = "Client-Secret"
        static let bridgeVersion = "Bridge-Version"
    }
}
