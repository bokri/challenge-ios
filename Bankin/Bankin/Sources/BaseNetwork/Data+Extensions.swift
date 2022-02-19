//
//  Data+Extensions.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift

extension Data {
    public func decode<T: Decodable>(type: T.Type) -> Single<T> {
        do {
            let object = try JSONDecoder().decode(type, from: self)
            return Single.just(object)
        } catch let error {
            return Single.error(error)
        }
    }
}
