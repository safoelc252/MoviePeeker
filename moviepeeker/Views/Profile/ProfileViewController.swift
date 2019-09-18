//
//  ProfileViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 12/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit

class ProfileViewController: BaseController {
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func prepareDisplay() {
        imageViewProfile.image = UIImage(named: "ico_account_image")?
            .withRenderingMode(.alwaysTemplate).tint(with: .gray)
    }
}
