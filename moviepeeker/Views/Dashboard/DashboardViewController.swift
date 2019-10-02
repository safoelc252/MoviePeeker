//
//  DashboardViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 12/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import Material


class DashboardViewController: UITabBarController {
    let options = MainTabOption.shared
    weak var browseListDelegate: BrowseListDelegate?
    weak var profileDelegate: ProfileDelegate?
    
    override func viewDidLoad() {
        self.delegate = self
        prepareControllers()
    }
}

extension DashboardViewController {
    fileprivate func prepareControllers() {
        let controllers = options.controllers()
        if controllers[Controller.browse.rawValue] is BrowseListViewController {
            browseListDelegate = controllers[Controller.browse.rawValue] as! BrowseListViewController
        }
        if controllers[Controller.profile.rawValue] is ProfileViewController {
            profileDelegate = controllers[Controller.profile.rawValue] as! ProfileViewController
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
        self.navigationItem.rightBarButtonItem = nil
        
        switch type {
        case .browse: addSearchBar()
        case .profile:
            addTitle("Profile")
            addSaveButton()
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
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 17.0)
        titleLabel.textColor = Color.darkText.primary
        navigationItem.titleView = titleLabel
    }
    fileprivate func addSaveButton() {
        let saveBtnItem = UIBarButtonItem(title: "Save",
                                          style: .done,
                                          target: self,
                                          action: #selector(didTapSave))
        saveBtnItem.tintColor = .white
        navigationItem.setRightBarButton(saveBtnItem, animated: false)
    }
    @objc fileprivate func didTapSave() {
        profileDelegate?.didTapSave()
    }
}

extension DashboardViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        browseListDelegate?.searchSong(term: searchBar.text ?? "")
    }
}
