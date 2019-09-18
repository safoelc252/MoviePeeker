//
//  BaseViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class BaseController: UIViewController, BaseCodeType {
    func prepareDisplay() { }
    func bindViewModel() { }
    func bindDisplay() { }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareDisplay()
        self.bindViewModel()
        self.bindDisplay()
    }
}
