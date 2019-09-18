//
//  MainTabOptions.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 12/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class MainTabOption {
    static let shared = {
        return MainTabOption()
    }()
    var vc1: UIViewController {
        let vc = BrowseListViewController()
        vc.tabBarItem = UITabBarItem(title: nil,
                                     image: UIImage(named:"ico_movie_library"),
                                     selectedImage: nil)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0,
                                                 bottom: -16, right: 0)
        return vc
    }
    var vc2:UIViewController {
        let vc = ProfileViewController()
        vc.tabBarItem = UITabBarItem(title: nil,
                                     image: UIImage(named: "ico_person"),
                                     selectedImage: nil)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0,
                                                 bottom: -16, right: 0)
        return vc
    }
    
    func controllers() -> [UIViewController] {
        return [vc1, vc2]
    }
}
