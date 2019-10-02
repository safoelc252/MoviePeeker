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
        case save(text: String, selector: Selector, target: Any)
        
        // Default
        func barButton() -> UIBarButtonItem {
            switch self {
            case .back(selector: let sel,
                       target: let target):
                return self.prepareButton(button: Buttons.back,
                                          selector: sel,
                                          target: target)
                
            case .save(text: let text, selector: let sel, target: let target):
                return self.prepareTextButton(text: text,
                                              color: .black,
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
        private func prepareTextButton(text: String,
                                       color: UIColor? = nil,
                                       selector: Selector,
                                       target: Any) -> UIBarButtonItem {
            let button = UIBarButtonItem(title: text,
                                         style: .done,
                                         target: target,
                                         action: selector)
            if color != nil {
                button.tintColor = color
            }

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
    
    func addTitle(_ title: String) {
        let titleLabel                = UILabel(frame: .zero)
        titleLabel.text               = title
        titleLabel.contentScaleFactor = Screen.scale
        titleLabel.font               = UIFont(name: "Verdana-Bold", size: 17.0)
        titleLabel.textColor          = Color.darkText.primary
        titleLabel.sizeToFit()
        navigationItem.titleView      = titleLabel
    }
}
