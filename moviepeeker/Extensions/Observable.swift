//
//  Observable.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public struct RxA<E: Any> {
    public typealias Driver = SharedSequence<DriverSharingStrategy, E>
}

extension ObservableType where Element == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
