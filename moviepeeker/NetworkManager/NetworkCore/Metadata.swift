//
//  Metadata.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

public struct Metadata<T> {
    public let resultCount: Int?
    public var results: T?
    public var error: Any?
    public var totalData: Int?
    public var totalPagination: Int?
    
    public init(resultCount: Int?, results: T?, error: Any?, totalData: Int?, totalPagination: Int?) {
        self.resultCount = resultCount
        self.results = results
        self.error = error
        self.totalData = totalData
        self.totalPagination = totalPagination
    }
}

extension Metadata: ImmutableMappable {
    public init(map: Map) throws {
        resultCount = try? map.value("resultCount")
        results = try? map.value("results")
        error = try? map.value("error")
        totalData = try? map.value("totalData")
        totalPagination = try? map.value("totalPagination")
    }
    
    // Object -> JSON
    public mutating func mapping(map: Map) {
        resultCount >>> map["resultCount"]
        results >>> map["results"]
        error >>> map["error"]
        totalData >>> map["totalData"]
        totalPagination >>> map["totalPagination"]
    }
}
