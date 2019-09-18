//
//  Profile.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 14/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper

struct Profile: ImmutableMappable {
    var displayName : String?
    var gender : String?
    var age : Int?
    
    init(map: Map) throws {
        displayName          = try map.value("displayName")
        gender               = try map.value("gender")
        age                  = try map.value("age")
    }

    mutating func mapping(map: Map) {
        displayName          <- map["displayName"]
        gender               <- map["gender"]
        age                  <- map["age"]
    }
}
