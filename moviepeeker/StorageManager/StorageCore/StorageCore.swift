//
//  StorageCore.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 30/09/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

enum StorageKey: String {
    case userProfile = "userProfile"
}

final class StorageCore<T: ImmutableMappable> {
    fileprivate let scheduler: MainScheduler
    init() {
        self.scheduler = MainScheduler.instance
    }
    
    /// Remove
    func remove(key: StorageKey) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            UserDefaults.standard
                .removeObject(forKey: key.rawValue)
            observer.on(.completed)
            return Disposables.create()
          }
    }
    
    func sets(mapper: BaseMappable, key: StorageKey) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            guard let data = try? JSONSerialization
                .data(withJSONObject: mapper.toJSON(), options: .prettyPrinted)
                else {
                    observer.on(.error(RxError.unknown))
                    return Disposables.create()
            }
            UserDefaults.standard.set(data, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
            
            observer.on(.completed)
            return Disposables.create()
          }
    }
    func sets(data: Any, key: StorageKey) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            UserDefaults.standard.set(data, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
            
            observer.on(.completed)
            return Disposables.create()
        }
    }
    
    func getMappable(key: StorageKey) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            if let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)  {
                
                do {
                    let map = try Mapper<T>().map(JSONObject: json)
                    observer.on(.next(map))
                    return Disposables.create()
                }
                catch {
                    observer.on(.error(RxError.unknown))
                    return Disposables.create()
                }
            }
            
            observer.on(.error(RxError.unknown))
            return Disposables.create()
        }
    }
    
    func getData(key: StorageKey) -> Observable<Any> {
        return Observable<Any>.create { observer -> Disposable in
            if let data = UserDefaults.standard.object(forKey: key.rawValue) {
                observer.on(.next(data))
                return Disposables.create()
            }
            observer.on(.error(RxError.unknown))
            return Disposables.create()
          }
    }
}
