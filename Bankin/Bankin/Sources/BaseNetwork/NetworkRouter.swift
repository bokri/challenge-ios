//
//  NetworkRouter.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import Alamofire

public protocol NetworkRouter: URLRequestConvertible {

    // MARK: URLRequestConvertible

    var endpoint: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
}

extension NetworkRouter {

    // MARK: Public Methods

    public func asURLRequest() throws -> URLRequest {
        let urlString = self.endpoint + self.path
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest = try self.encoding.encode(urlRequest, with: self.parameters)
        return urlRequest
    }
}
