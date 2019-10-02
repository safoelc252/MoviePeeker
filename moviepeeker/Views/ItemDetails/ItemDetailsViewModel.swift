//
//  ItemDetailsViewModel.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 02/10/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ItemDetailsViewModel: ViewModelType {
    var userProfile = Profile.empty()
    var item: SearchItem!
    
    var triggerLoad = BehaviorRelay<Bool>(value: false)
    var triggerSave = BehaviorRelay<Bool>(value: false)
    
    let loadStorage = StorageManager<Profile>().makeGenericStorage()
    let saveStorage = StorageManager<EmptyModel>().makeGenericStorage()
    let activityTracker = ActivityTracker()
    let errorTracker = ErrorTracker()
    
    func transform(input: ItemDetailsViewModel.Input) -> ItemDetailsViewModel.Output {
            let resultLoad = input.triggerLoad
                .filter { (value) -> Bool in
                    return value
                }
                .flatMapLatest { _ -> RxA<Profile>.Driver in
                    return self.loadStorage.getUserProfile()
                        .trackActivity(self.activityTracker)
                        .trackError(self.errorTracker)
                        .asDriverOnErrorJustComplete()
            }
            let resultSave = input.triggerSave
                .filter { (value) -> Bool in
                    return value
                }
                .flatMapLatest { _ -> RxA<EmptyModel>.Driver in
                    return self.saveStorage.saveUserProfile(profile: self.userProfile)
                        .trackActivity(self.activityTracker)
                        .trackError(self.errorTracker)
                        .asDriverOnErrorJustComplete()
            }
            
            return Output(error: errorTracker.asDriver(),
                          resultLoad: resultLoad,
                          resultSave: resultSave)
        }
        struct Input {
            let triggerLoad: Driver<Bool>
            let triggerSave: Driver<Bool>
        }
        struct Output {
            let error: Driver<Error>
            let resultLoad: Driver<Profile>
            let resultSave: Driver<EmptyModel>
        }
}

extension ItemDetailsViewModel {
    func bindError(vc: ItemDetailsViewController, error: Error) {
        vc.view.showToast(message: error.localizedDescription)
    }
    func bindLoad(vc: ItemDetailsViewController, response: Profile) {
        userProfile = response
        vc.prepareData()
        vc.prepareButton()
    }
    func bindSave(vc: ItemDetailsViewController, response: EmptyModel) {
        vc.navigationController?.popViewController(animated: true)
    }
}

extension ItemDetailsViewModel {
    func didTapAdd() {
        if (userProfile.favoriteItems?
            .first(where: { $0.trackId == self.item.trackId }) != nil) {
            userProfile.favoriteItems?.removeAll(where: {  $0.trackId == self.item.trackId })
        } else {
            userProfile.favoriteItems?.append(item)
        }
    }
}
