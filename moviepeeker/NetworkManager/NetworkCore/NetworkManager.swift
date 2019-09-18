//
//  NetworkManager.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import ObjectMapper

// MARK: - Conslidated network for all endpoints
public final class NetworkManager<T: ImmutableMappable> {
    private var networkCore: NetworkCore<T>!
    
    public init() {
        networkCore = NetworkCore<T>(APIConfig.restAPI)
    }
    
    /// Search network
    public func makeSearchNetwork() -> SearchNetwork<T> {
        return SearchNetwork<T>(network: networkCore)
    }
}
