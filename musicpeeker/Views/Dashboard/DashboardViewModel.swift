//
//  DashboardViewModel.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DashboardViewModel: ViewModelType {
    // Data
    var dataItems = BehaviorRelay<[SearchItem]>(value: [])
    
    // triger
    var triggerSearch = BehaviorRelay<Bool>(value: false)
    
    // Network
    let networkSearch = NetworkManager<SearchItem>().makeSearchNetwork()
    let activityTracker = ActivityTracker()
    let errorTracker = ErrorTracker()
    
    struct Input {
        let loadSearch: Driver<Bool>
    }

    struct Output {
        let error: Driver<Error>
        let searchItems: Driver<Metadata<[SearchItem]>>
    }
    
    func transform(input: DashboardViewModel.Input) -> DashboardViewModel.Output {
        let search = input.loadSearch
            .filter { (value) -> Bool in
                return value
            }
            .map { _ -> [String: String] in
                let param = ["term": "versace",
                             "country": "us"]
                return param
            }.flatMapLatest { param -> RxA<Metadata<[SearchItem]>>.Driver in
                return self.networkSearch.search(params: param)
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        return Output(error: errorTracker.asDriver(),
                      searchItems: search)
    }
}

extension DashboardViewModel {
    func bindError(vc: DashboardViewController, error: Error) {
        debugPrint(error)
    }
    func bindSearch(vc: DashboardViewController, response: Metadata<[SearchItem]>) {
        if let result = response.results {
            dataItems.accept(result)
        }
    }
}
