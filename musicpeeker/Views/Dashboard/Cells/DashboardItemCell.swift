//
//  DashboardItemCell.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class DashboardItemCell: UITableViewCell {
    static let nib = UINib(nibName: "DashboardItemCell", bundle: nil)
    static let identifier = "DashboardItemCellID"

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var imageTrackArt: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: SearchItem) {
        labelTitle.text = data.trackName
        // etc
    }
}
