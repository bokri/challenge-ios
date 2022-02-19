//
//  BanksWrapper.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import Realm
import RealmSwift

public class BanksWrapper: Object, Codable {
    @objc dynamic var id: Int = 0
    var resources: List<Bank> = List<Bank>()
    @objc dynamic var pagination: Pagination?

    public override static func primaryKey() -> String? {
        return "id"
    }
    
    override init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        if let array = try? container?.decode([Bank].self, forKey: .resources) {
            self.resources.append(objectsIn: array)
        } else {
            throw NetworkError.malformedJson
        }

        self.pagination = try? container?.decode(Pagination.self, forKey: .pagination)
    }
}

public class Pagination: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var nextUri: String?
    
    override init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        self.nextUri = try? container?.decode(String.self, forKey: .nextUri)
    }

    public override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case nextUri = "next_uri"
    }
}
