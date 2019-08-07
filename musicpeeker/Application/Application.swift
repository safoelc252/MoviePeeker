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
        prepareRootView()
    }
}

extension Application {
    open func prepareRootView() {
        let keyWindow = UIApplication.shared.keyWindow
        let controller = createController()
        keyWindow?.rootViewController = controller
    }
    open func createController() -> UIViewController {
        let baseView = BaseController()
        return baseView.getDashboard()
    }
}
