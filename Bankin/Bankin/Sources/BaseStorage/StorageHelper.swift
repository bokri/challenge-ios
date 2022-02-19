//
//  StorageHelper2.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

public enum StorageHelper {

    /// Create Database if does not exist or get the existing database
    ///
    /// - Parameter name: Database name
    /// - Parameter version: Database version number
    ///
    public static func configureDatabase(name: String, version: UInt64 = 1, shouldCompactLaunch: Bool = false) throws -> StorageProtocol {
        var configuration = Realm.Configuration(fileURL: URL(fileURLWithPath: RLMRealmPathForFile("\(name).realm")))
        configuration.schemaVersion = version
        configuration.deleteRealmIfMigrationNeeded = true

        if shouldCompactLaunch == true {
            configuration.shouldCompactOnLaunch = { (totalBytes: Int, usedBytes: Int) -> Bool in
                // Compact if the file is over 500KB in size and less than 20% 'used'
                let fifiveHundredsKB = 500 * 1024
                return (totalBytes > fifiveHundredsKB) && (Double(usedBytes) / Double(totalBytes)) < 0.2
            }
        }

        guard let realm = try? Realm(configuration: configuration) else {
            throw StorageErrors.storage
        }
        return realm as StorageProtocol
    }
}
