//
//  AppNavigationController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {
    // MARK: - Lifecycle
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        navigationBar.barTintColor = UIColor.themeDark
    }
}

