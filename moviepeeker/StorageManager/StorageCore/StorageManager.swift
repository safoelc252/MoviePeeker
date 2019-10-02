//
//  StorageManager.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 01/10/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

public final class StorageManager<T: ImmutableMappable> {
    private var storageCore: StorageCore<T>!
    
    public init() {
        storageCore = StorageCore<T>()
    }
    
    public func makeGenericStorage() -> GenericStorage<T> {
        return GenericStorage(storage: storageCore)
    }
}
