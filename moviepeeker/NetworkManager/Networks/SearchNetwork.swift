//
//  SearchNetwork.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

public final class SearchNetwork<T: ImmutableMappable> {
    fileprivate var network: NetworkCore<T>
    init(network: NetworkCore<T>) {
        self.network = network
    }
    
    public func search(params: [String: Any]) -> Observable<Metadata<[T]>> {
        return network.getItems("search", parameters: params)
    }
}
