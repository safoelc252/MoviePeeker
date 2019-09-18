//
//  NetworkConfig.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation

struct APIConfig {
    // Change pointing here. True or False
    static let isLive: Bool = true

    // Dont change this.
    static let restAPI = APIConfig.isLive ? _api.rest.live : _api.rest.stg
    private struct _api {
        struct rest {
            static let live = "https://itunes.apple.com"
            static let stg  = "https://itunes.apple.com"
        }
    }
}
