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
    var userProfile = BehaviorRelay<Profile>(value: Profile.empty())
    
    var triggerLoad = BehaviorRelay<Bool>(value: false)
    var triggerSave = BehaviorRelay<Bool>(value: false)
    
    
    let networkSearch = NetworkManager<SearchItem>().makeSearchNetwork()
    let genericStorage = StorageManager().makeGenericStorage()
    
    func transform(input: ProfileViewModel.Input) -> ProfileViewModel.Output {
        return Output()
    }
    struct Input {}
    struct Output {}
}
