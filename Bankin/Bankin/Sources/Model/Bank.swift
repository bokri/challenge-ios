//
//  Bank.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RealmSwift
import Realm

public class Bank: Object, Codable {
    
    // MARK: - Properties

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var countryCode: String = ""
    @objc dynamic var logoUrl: String = ""
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case countryCode = "country_code"
        case logoUrl = "logo_url"
    }
    
    // MARK: - Realm Primary Key

    public override static func primaryKey() -> String? {
        return "id"
    }
}
