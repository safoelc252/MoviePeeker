//
//  ItemDetailDescriptionCell.swift
//  moviepeeker
//
//  Created by Cleofas Villarin on 18/09/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class ItemDetailDescriptionCell: UITableViewCell {
    static let nib = UINib(nibName: "ItemDetailDescriptionCell", bundle: nil)
    static let identifier = "ItemDetailDescriptionCellID"
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    func setData(title: String, description: String) {
        labelTitle.text = title
        labelDescription.text = description
    }
}
