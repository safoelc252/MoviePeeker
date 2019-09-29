//
//  ItemDetailsViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 14/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class ItemDetailsViewController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    var item: SearchItem?
    
    convenience init(item: SearchItem) {
        self.init()
        self.item = item
    }
    
    override func prepareDisplay() {
        prepareNavigation()
        prepareTableView()
    }
    
    func prepareNavigation() {
        let buttonBack: BaseController.ButtonType = .back(selector: #selector(didTapBack), target: self)
        addLeftButtons(buttons: [buttonBack])
        addTitle("Item Details")
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemDetailTrackArtCell.nib,
                           forCellReuseIdentifier: ItemDetailTrackArtCell.identifier)
        tableView.register(ItemDetailDescriptionCell.nib,
                           forCellReuseIdentifier: ItemDetailDescriptionCell.identifier)
        tableView.separatorStyle = .none
    }
}

extension ItemDetailsViewController {
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension ItemDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnedCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailDescriptionCell.identifier) as? ItemDetailDescriptionCell {
            cell.setData(title: item?.trackName ?? "",
                         description: item?.longDescription ?? "")
            cell.selectionStyle = .none
            returnedCell = cell
        }
        return returnedCell
    }
    
    
}
