//
//  ItemDetailTrackArtCell.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 19/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import SDWebImage

class ItemDetailTrackArtCell: UITableViewCell {
    static let nib = UINib(nibName: "ItemDetailTrackArtCell", bundle: nil)
    static let identifier = "ItemDetailTrackArtCellID"
    
    @IBOutlet weak var imageViewArt: UIImageView!
    
    func setData(img: String) {
        if let url = URL(string: img) {
            let indicator = SDWebImageActivityIndicator()
            indicator.startAnimatingIndicator()
            indicator.indicatorView.style = .gray
            imageViewArt.sd_imageIndicator = indicator
            imageViewArt.sd_setImage(with: url)
        }
    }
}
