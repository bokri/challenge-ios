//
//  BaseNetwork.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import Alamofire
import RxSwift

public class BaseNetwork {

    // MARK: - Properties

    private var sessionManager: Alamofire.Session
    private var configuration: URLSessionConfiguration
    private var headers: HTTPHeaders
    
    // MARK: Constructor

    public init(disableCache: Bool = false) {
        self.configuration = URLSessionConfiguration.default
        self.headers = HTTPHeaders.default
        self.sessionManager = Alamofire.Session(configuration: self.configuration)
        if disableCache {
            self.configuration.requestCachePolicy = .reloadIgnoringCacheData
        }
        
        self.addHeaders(headers: buildBaseHeaders())
    }

    /// Add header to default alamodfire Headers
    ///
    /// - Parameter headers: Headerts to add
    public func addHeaders(headers: [String: String]) {
        for (key, value) in headers {
            self.headers.add(name: key, value: value)
        }

        // add the headers
        self.configuration.httpAdditionalHeaders =  self.headers.dictionary

        // create a session manager with the configuration
        self.sessionManager = Alamofire.Session(configuration: self.configuration)
    }

    /// this method makes a request without any additional header
    ///
    /// - Parameter networkRouter: a formatted request
    /// - Parameter timeout: Double
    /// - Returns: Reactive<DataRequest>
    public func request(networkRouter: NetworkRouter, timeout: Double? = nil) -> Reactive<DataRequest> {
        return self.request(networkRouter: networkRouter, headers: [:], timeout: timeout)
    }
    
    /// this method makes a request without additional headers
    ///
    /// - Parameter networkRouter: a formatted request
    /// - Parameter headers: additional Headers
    /// - Parameter timeout: Double
    /// - Returns: Reactive<DataRequest>
    public func request(networkRouter: NetworkRouter, headers: [String: String], timeout: Double? = nil) -> Reactive<DataRequest> {
        let request = self.sessionManager.request("\(networkRouter.endpoint)\(networkRouter.path)",
            method: networkRouter.method,
            parameters: networkRouter.parameters,
            encoding: networkRouter.encoding,
            headers: HTTPHeaders(headers),
            requestModifier: {
                    $0.timeoutInterval = timeout ?? BaseNetworkConstants.timeout
            })
        return request.rx
    }
    
    // MARK: - Manage Headers

    public func buildBaseHeaders() -> [String: String] {
        return [
            BaseNetworkConstants.HeaderKeys.bridgeVersion: BaseNetworkConstants.networkBridgeVersion,
            BaseNetworkConstants.HeaderKeys.clientId: BaseNetworkConstants.clientId,
            BaseNetworkConstants.HeaderKeys.clientSecret: BaseNetworkConstants.clientSecret
        ]
    }
}
