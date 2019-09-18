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
    
    public func setCorner(withValue value: Int) {
        self.layer.cornerRadius = CGFloat(value)
        self.layer.masksToBounds = true
    }
    
    public func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        toastLabel.sizeToFit()
        
        // add padding
        var frame = toastLabel.frame
        frame.size.width += 16
        frame.size.height += 16
        
        // realign
        frame.origin.x = (self.frame.size.width - frame.size.width) / 2
        frame.origin.y = (self.frame.size.height - frame.size.height - 50)
        toastLabel.frame = frame
        
        // display
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
