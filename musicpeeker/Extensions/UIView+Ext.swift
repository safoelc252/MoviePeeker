//
//  UIView+Ext.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 11/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    open var cornerRadius: Int {
        get {
            return self.cornerRadius
        } set {
            self.setCorner(withValue: newValue)
        }
    }
}


extension UIView {
    public func setCorner(withValue value: Int) {
        self.layer.cornerRadius = CGFloat(value)
        self.layer.masksToBounds = true
    }
}
