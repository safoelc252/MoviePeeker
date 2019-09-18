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

class BrowseListViewModel: ViewModelType {
    // Data
    var dataItems = BehaviorRelay<[SearchItem]>(value: [])
    
    // triger
    var triggerSearch = BehaviorRelay<String>(value: "")
    
    // Network
    let networkSearch = NetworkManager<SearchItem>().makeSearchNetwork()
    let activityTracker = ActivityTracker()
    let errorTracker = ErrorTracker()
    
    struct Input {
        let loadSearch: Driver<String>
    }

    struct Output {
        let error: Driver<Error>
        let searchItems: Driver<Metadata<[SearchItem]>>
    }
    
    func transform(input: BrowseListViewModel.Input) -> BrowseListViewModel.Output {
        let search = input.loadSearch
            .filter { (value) -> Bool in
                return !value.isEmpty
            }
            .map { term -> [String: String] in
                let param = ["term": term,
                             "country": "au",
                             "media": "movie"]
                return param
            }.flatMapLatest { param -> RxA<Metadata<[SearchItem]>>.Driver in
                self.dataItems.accept([])
                return self.networkSearch.search(params: param)
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        return Output(error: errorTracker.asDriver(),
                      searchItems: search)
    }
}

extension BrowseListViewModel {
    func bindError(vc: BrowseListViewController, error: Error) {
        vc.view.showToast(message: error.localizedDescription)
    }
    func bindSearch(vc: BrowseListViewController, response: Metadata<[SearchItem]>) {
        if let result = response.results {
            if result.isEmpty {
                vc.tabBarController?.view.showToast(message: "Result is empty")
            }
            dataItems.accept(result)
        }
    }
}
