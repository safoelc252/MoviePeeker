//
//  ProfileViewModel.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 29/09/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel: ViewModelType {
    var userProfile = Profile.empty()
    var favoriteItems = BehaviorRelay<[SearchItem]>(value: [])
    var ageList = BehaviorRelay<[Int]>(value: (1...100).map{$0})
    var genderList = BehaviorRelay<[String]>(value: ["Male", "Female"])
    
    var triggerLoad = BehaviorRelay<Bool>(value: false)
    var triggerSave = BehaviorRelay<Bool>(value: false)
    
    let loadStorage = StorageManager<Profile>().makeGenericStorage()
    let saveStorage = StorageManager<EmptyModel>().makeGenericStorage()
    let activityTracker = ActivityTracker()
    let errorTracker = ErrorTracker()
    
    func transform(input: ProfileViewModel.Input) -> ProfileViewModel.Output {
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

extension ProfileViewModel {
    func bindError(vc: ProfileViewController, error: Error) {
        vc.view.showToast(message: error.localizedDescription)
    }
    func bindLoad(vc: ProfileViewController, response: Profile) {
        userProfile = response
        vc.prepareData()
    }
    func bindSave(vc: ProfileViewController, response: EmptyModel) {
        let alert = UIAlertController(title: "Message", message: "Data saved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
