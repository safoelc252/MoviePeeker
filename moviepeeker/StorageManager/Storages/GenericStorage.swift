//
//  GenericStorage.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 01/10/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

public final class GenericStorage<T: ImmutableMappable> {
    fileprivate var storage: StorageCore<T>!
    init(storage: StorageCore<T>) {
        self.storage = storage
    }
    
    public func getUserProfile() -> Observable<T> {
        return storage.getMappable(key: .userProfile)
    }
    
    public func saveUserProfile(profile: Profile) -> Observable<T> {
        return storage.sets(mapper: profile, key: .userProfile)
    }
}
