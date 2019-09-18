//
//  Indicator.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 14/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import RxSwift
import RxCocoa
import Material

class IndicatorView: UIView {
    public static let shared   = IndicatorView()
    fileprivate var activityView: NVActivityIndicatorView?
    fileprivate let keyWindow  = UIApplication.shared.keyWindow
    fileprivate let identifier = "indicator"
    func show() {
        createView()
        activityView?.startAnimating()
    }
    func hide() {
        activityView?.stopAnimating()
        removeIndicator()
    }
}

extension IndicatorView {
    fileprivate func createView() {
        // Don't add loader if it's already loaded
        guard !isIndicatorAdded() else { return }
        
        // Loader
        activityView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0,
                                                             width: 30.0,
                                                             height: 30.0),
                                               type: .circleStrokeSpin,
                                               color: .red,
                                               padding: 0.0)
        // Container View/Child
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        guard let activityView = self.activityView else { return }
        containerView.restorationIdentifier = self.identifier
        containerView.layout(activityView).center()
        
        // Add to keywindow/Parent
        keyWindow?.layout(containerView)
            .bottom().top()
            .left().right()
        keyWindow?.endEditing(true)
    }
    fileprivate func removeIndicator() {
        guard let keyWindow = keyWindow else { return }
        for item in keyWindow.subviews
            where item.restorationIdentifier == self.identifier {
                item.removeFromSuperview()
        }
    }
    fileprivate func isIndicatorAdded() -> Bool {
        guard let keyWindow = keyWindow else { return false }
        for item in keyWindow.subviews
            where item.restorationIdentifier == self.identifier {
                return true
        }
        return false
    }
}

extension Reactive where Base: IndicatorView {
    internal static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) {progressHUD, isVisible in
            if isVisible {
                IndicatorView.shared.show()
            } else {
                IndicatorView.shared.hide()
            }
        }
    }
}
