//
//  StorageManager.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 01/10/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation

public final class StorageManager {
    private var storageCore: StorageCore!
    
    public init() {
        storageCore = StorageCore()
    }
    
    public func makeGenericStorage() -> GenericStorage {
        return GenericStorage(storage: storageCore)
    }
}
