//
//  NavigationItems.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 27/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import Material

extension BaseController {
    enum ButtonType {
        case back(selector: Selector, target: Any)
        
        // Default
        func barButton() -> UIBarButtonItem {
            switch self {
            case .back(selector: let sel,
                       target: let target):
                return self.prepareButton(button: Buttons.back,
                                          selector: sel,
                                          target: target)
            }
        }
        
        private func prepareButton(button: IconButton,
                                   selector: Selector,
                                   target: Any) -> UIBarButtonItem {
            let button = UIBarButtonItem(image: button.image,
                                         style: .done,
                                         target: target,
                                         action: selector)
            return button
        }
    }
    func addLeftButtons(buttons: [ButtonType]) {
        self.navigationItem
            .setLeftBarButtonItems(buttons.map { $0.barButton() },
                                   animated: true)
    }
    func addRightButtons(buttons: [ButtonType]) {
        self.navigationItem
            .setRightBarButtonItems(buttons.map { $0.barButton() },
                                    animated: true)
    }
}
