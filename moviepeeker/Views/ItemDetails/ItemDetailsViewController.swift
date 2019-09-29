//
//  ItemDetailsViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 14/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import ObjectMapper

class ItemDetailsViewController: BaseController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    
    var item: SearchItem!
    var userProfile = Profile.empty()
    
    convenience init(item: SearchItem) {
        self.init()
        self.item = item
    }
    
    override func prepareDisplay() {
        prepareNavigation()
        prepareData()
        prepareButton()
    }
    
    func prepareNavigation() {
        let buttonBack: BaseController.ButtonType = .back(selector: #selector(didTapBack), target: self)
        addLeftButtons(buttons: [buttonBack])
        addTitle("Item Details")
    }
    
    func prepareButton() {
        buttonAdd.backgroundColor = .themeLight
        
        if (userProfile.favoriteItems?
            .first(where: { $0.trackId == self.item.trackId }) != nil) {
            buttonAdd.setTitle("Remove from favorites", for: .normal)
        } else {
            buttonAdd.setTitle("Add to favorites", for: .normal)
        }
    }
    
    func prepareData() {
        labelTitle.text = item?.trackName ?? ""
        labelDescription.text = item?.longDescription ?? ""
        
        if let data = UserDefaults.standard.object(forKey: "userProfile") as? Data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let mapped = try? Mapper<Profile>().map(JSONObject: json) as Profile {
            userProfile = mapped
        }
    }
    
    @IBAction func didTapAdd(_ sender: UIButton) {
        if (userProfile.favoriteItems?
            .first(where: { $0.trackId == self.item.trackId }) != nil) {
            userProfile.favoriteItems?.removeAll(where: {  $0.trackId == self.item.trackId })
        } else {
            userProfile.favoriteItems?.append(item)
        }
        prepareButton()
    }
}

extension ItemDetailsViewController {
    @objc func didTapBack() {
        guard let data = try? JSONSerialization.data(withJSONObject: userProfile.toJSON(), options: .prettyPrinted) else { return }
        UserDefaults.standard.set(data, forKey: "userProfile")
        UserDefaults.standard.synchronize()
        navigationController?.popViewController(animated: true)
    }
}
