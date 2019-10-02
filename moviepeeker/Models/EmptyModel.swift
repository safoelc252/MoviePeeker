//
//  EmptyModel.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 01/10/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper

struct EmptyModel { }

extension EmptyModel: ImmutableMappable {
    init(map: Map) throws { }

    mutating func mapping(map: Map) { }
}
