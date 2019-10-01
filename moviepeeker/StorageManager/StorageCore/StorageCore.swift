//
//  StorageCore.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 30/09/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

enum StorageKey: String {
    case userProfile = "userProfile"
}

final class StorageCore {
    /// Remove
    func remove(key: StorageKey) {
        UserDefaults.standard
            .removeObject(forKey: key.rawValue)
    }
    /// Save data type
    struct set {
        // Archiving
        static func addMapper(_ mapper: BaseMappable, key: StorageKey) {
            guard let data = try? JSONSerialization.data(withJSONObject: mapper.toJSON(), options: .prettyPrinted) else { return }
            UserDefaults.standard.set(data, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static func sets(data: Any, key: StorageKey) {
        UserDefaults.standard.set(data, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    /// Get data type
    struct get<T: BaseMappable> {
        static func getData(key: StorageKey) -> T? {
            if let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return nil }
                let map = Mapper<T>().map(JSONObject: json)
                return map
            }
            return nil
        }
    }
    static func gets(key: StorageKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
}
