//
//  ProfileViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 12/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper

protocol ProfileDelegate: class {
    func didTapSave()
}

class ProfileViewController: BaseController {
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteItems: [SearchItem] = []
    var userProfile: Profile = Profile.empty()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareData()
    }

    override func prepareDisplay() {
        prepareTableView()
    }
    
    func prepareData() {
        if let data = UserDefaults.standard.object(forKey: "userProfile") as? Data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let mapped = try? Mapper<Profile>().map(JSONObject: json) as Profile {
            userProfile = mapped
            textFieldName.text = userProfile.displayName
            textFieldAge.text = "\(userProfile.age ?? 1)"
            textFieldGender.text = userProfile.gender ?? ""
            favoriteItems = userProfile.favoriteItems ?? []
            tableView.reloadData()
        } else {
            saveData()
        }
    }
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrowseListItemCell.nib,
                           forCellReuseIdentifier: BrowseListItemCell.identifier)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

extension ProfileViewController: ProfileDelegate {
    func didTapSave() {
        saveData()
    }
    
    func saveData() {
        userProfile.displayName = textFieldName.text
        userProfile.age  = Int(textFieldAge.text ?? "1")
        userProfile.gender = textFieldGender.text
        guard let data = try? JSONSerialization.data(withJSONObject: userProfile.toJSON(), options: .prettyPrinted) else { return }
        UserDefaults.standard.set(data, forKey: "userProfile")
        UserDefaults.standard.synchronize()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnedCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: BrowseListItemCell.identifier) as? BrowseListItemCell {
            cell.setData(data: favoriteItems[indexPath.row])
            cell.contentView.backgroundColor = .white
            cell.selectionStyle = .none
            returnedCell = cell
        }
        return returnedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoDetails(item: favoriteItems[indexPath.row])
    }
}
