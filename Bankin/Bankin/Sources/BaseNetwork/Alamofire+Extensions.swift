//
//  Alamofire+Extensions.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import Alamofire
import RxSwift

extension Request: ReactiveCompatible {}

// MARK: - DataRequest
extension Reactive where Base: DataRequest {

    // Alamofire Rx extension for JSON Response
    public func responseAsJSON() -> Single<Data> {
        return Single<Data>.create { single in
            let request = self.base.responseJSON { response in
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode, statusCode >= 400 {
                        single(.error(NetworkError.networkError))
                        return
                    }
    
                    if let data = response.data {
                        single(.success(data))
                    } else {
                        single(.error(NetworkError.networkError))
                    }
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
