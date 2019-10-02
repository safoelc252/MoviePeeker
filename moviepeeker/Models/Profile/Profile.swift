//
//  Profile.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 14/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Profile {
    var displayName : String?
    var photoUrl : String?
    var gender : String?
    var age : Int?
    var favoriteItems: [SearchItem]?
    
    static func empty() -> Profile {
        return Profile(displayName: "", photoUrl: "", gender: "", age: 1, favoriteItems: [])
    }
}

extension Profile: ImmutableMappable {
    public init(map: Map) throws {
        displayName          = try? map.value("displayName")
        photoUrl             = try? map.value("photoUrl")
        gender               = try? map.value("gender")
        age                  = try? map.value("age")
        favoriteItems        = try? map.value("favoriteItems")
    }

    mutating public func mapping(map: Map) {
        displayName          <- map["displayName"]
        photoUrl             <- map["photoUrl"]
        gender               <- map["gender"]
        age                  <- map["age"]
        favoriteItems        <- map["favoriteItems"]
    }
}
