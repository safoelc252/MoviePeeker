//
//  DashboardViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 12/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import Material

protocol DashboardDelegate: class {
    func searchSong(term: String)
}

class DashboardViewController: UITabBarController {
    let options = MainTabOption.shared
    weak var dashboardDelegate: DashboardDelegate?
    
    override func viewDidLoad() {
        self.delegate = self
        prepareControllers()
    }
}

extension DashboardViewController {
    fileprivate func prepareControllers() {
        let controllers = options.controllers()
        if controllers[Controller.browse.rawValue] is BrowseListViewController {
            dashboardDelegate = controllers[Controller.browse.rawValue] as! BrowseListViewController
        }
        setViewControllers(controllers, animated: true)
        tabBar.tintColor = UIColor.themeLight
        addSearchBar()
    }
}

extension DashboardViewController:  UITabBarControllerDelegate {
    private enum Controller: Int {
        case browse = 0
        case profile = 1
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let type = Controller(rawValue: tabBarController.selectedIndex) else { return }
        
        // clear first
        self.navigationItem.titleView = nil

        switch type {
        case .browse: addSearchBar()
        case .profile: addTitle("Profile")
        }
    }

    fileprivate func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search movie title"
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        navigationItem.titleView = searchBar
    }
    fileprivate func addTitle(_ title: String) {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.sizeToFit()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 20.0)
        titleLabel.textColor = .white
        navigationItem.titleView = titleLabel
    }
}

extension DashboardViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dashboardDelegate?.searchSong(term: searchBar.text ?? "")
    }
}
