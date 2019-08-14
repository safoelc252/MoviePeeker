//
//  DashboardItemCell.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import SDWebImage

class BrowseListItemCell: UITableViewCell {
    static let nib = UINib(nibName: "BrowseListItemCell", bundle: nil)
    static let identifier = "BrowseListItemCellID"

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelImage: UILabel!
    @IBOutlet weak var imageTrackArt: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // temp apply gradient
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [
            UIColor.themeDark.cgColor,
            UIColor.themeLight.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 0.6, 1.0]
        viewCard.layer.insertSublayer(gradient, at: 0)
    }
    
    func setData(data: SearchItem) {
        labelTitle.text = data.trackName ?? ""
        labelPrice.text = "\(data.currency ?? "USD") \(data.trackPrice ?? 0)"
        labelGenre.text = data.primaryGenreName ?? ""
        if let artImgUrl = data.artworkUrl100,
            let url = URL(string: artImgUrl) {
            let indicator = SDWebImageActivityIndicator()
            indicator.startAnimatingIndicator()
            indicator.indicatorView.style = .gray
            imageTrackArt.sd_imageIndicator = indicator
            imageTrackArt.sd_setImage(with: url) { (image, error, cacheType, imageURL) in
                if error != nil {
                    self.setLabelImage(text: data.trackName ?? "")
                }
            }
        } else {
            setLabelImage(text: data.trackName ?? "")
        }
    }
    fileprivate func setLabelImage(text: String) {
        labelImage.backgroundColor = .black
        labelImage.textColor = .white
        labelImage.text = text
        labelImage.adjustsFontSizeToFitWidth = true
        labelImage.minimumScaleFactor = 0.2
        labelImage.numberOfLines = 2
    }
}
