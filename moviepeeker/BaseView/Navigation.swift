//
//  Navigation.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

extension BaseController {
    func getDashboard() -> UIViewController {
        let vc = DashboardViewController()
        let navi = AppNavigationController(rootViewController: vc)
        return navi
    }
    
    func gotoDetails(item: SearchItem) {
        let vc = ItemDetailsViewController(item: item)
        self.navigationController?
            .pushViewController(vc, animated: true)
    }
}
