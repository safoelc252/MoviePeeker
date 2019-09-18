//
//  ActivityTracker.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public class ActivityTracker: SharedSequenceConvertibleType {
    
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy
    private let _lock = NSRecursiveLock()
    private let _variable = BehaviorRelay(value: false)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    public init() {
        _loading = _variable.asDriver()
            .distinctUntilChanged()
    }
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    private func subscribed() {
        _lock.lock()
        _variable.accept(true)
        _lock.unlock()
    }
    private func sendStopLoading() {
        _lock.lock()
        _variable.accept(false)
        _lock.unlock()
    }
    public func asSharedSequence() -> SharedSequence<DriverSharingStrategy, ActivityTracker.Element>  {
        return _loading
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityTracker) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}
