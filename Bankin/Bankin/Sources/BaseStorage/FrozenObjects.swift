//
//  FrozenObjects.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RealmSwift
import Realm

protocol FrozenObject: AnyObject {
    func unFreeze() -> Self
}

extension Object: FrozenObject {
    func unFreeze() -> Self {
        if self.isFrozen {
            return self.thaw() ?? self
        }

        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            if property.isArray, let data = value as? FrozenObject {
                setValue(data.unFreeze(), forKey: property.name)
            } else if property.type == .object, let data = value as? FrozenObject {
                setValue(data.unFreeze(), forKey: property.name)
            }
        }

        return self
    }
}

extension List: FrozenObject {
    func unFreeze() -> List<Element> {
        let result = List<Element>()
        forEach { (el) in
            if let object = ((el as? FrozenObject)?.unFreeze() as? Element) {
                result.append(object)
            } else {
                result.append(el)
            }
        }
        return result
    }
}

extension Array where Element: FrozenObject {
    func unFreezeArray() -> [Element] {
        return self.map { (el) -> Element in
            el.unFreeze()
        }
    }
}

extension Array where Element: Object {
    func unManage() {
        self.forEach { (el) in
            if el.realm != nil {
                el.setValue(nil, forKey: "realm")
            }
        }
    }
}
