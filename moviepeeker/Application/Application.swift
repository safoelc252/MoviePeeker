//
//  Application.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

@objc
public class Application: NSObject {
    static let shared = Application()
    var window: UIWindow!
    func configure(window: UIWindow) {
        self.window = window
        prepareRootView()
    }
}

extension Application {
    open func prepareRootView() {
        let controller = createController()
        self.window?.rootViewController = controller
    }
    open func createController() -> UIViewController {
        let baseView = BaseController()
        return baseView.getDashboard()
    }
}
