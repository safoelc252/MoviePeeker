//
//  ItemDetailsViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 14/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxCocoa

class ItemDetailsViewController: BaseController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    
    let viewModel = ItemDetailsViewModel()
    let disposeBag = DisposeBag()
    
    convenience init(item: SearchItem) {
        self.init()
        self.viewModel.item = item

        let key: StorageKey = .userProfile
        if UserDefaults.standard.object(forKey: key.rawValue) as? Data == nil {
            UserDefaults.standard.set(Profile.empty(), forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.triggerLoad.accept(true)
    }
    
    override func prepareDisplay() {
        prepareNavigation()
    }
    
    override func bindViewModel() {
        let input = ItemDetailsViewModel.Input(triggerLoad: viewModel.triggerLoad.asDriver(),
                                               triggerSave: viewModel.triggerSave.asDriver())
        
        let output = viewModel.transform(input: input)
        output.error
            .drive(Binder.init(self, binding: viewModel.bindError))
            .disposed(by: disposeBag)
        output.resultLoad
            .drive(Binder.init(self, binding: viewModel.bindLoad))
            .disposed(by: disposeBag)
        output.resultSave.drive(Binder.init(self, binding: viewModel.bindSave))
            .disposed(by: disposeBag)
    }
    
    func prepareNavigation() {
        let buttonBack: BaseController.ButtonType = .back(selector: #selector(didTapBack), target: self)
        addLeftButtons(buttons: [buttonBack])
        addTitle("Item Details")
    }
    
    func prepareButton() {
        buttonAdd.backgroundColor = .themeLight
        
        if (viewModel.userProfile.favoriteItems?
            .first(where: { $0.trackId == self.viewModel.item.trackId }) != nil) {
            buttonAdd.setTitle("Remove from favorites", for: .normal)
        } else {
            buttonAdd.setTitle("Add to favorites", for: .normal)
        }
    }
    
    func prepareData() {
        labelTitle.text = viewModel.item?.trackName ?? ""
        labelDescription.text = viewModel.item?.longDescription ?? ""
    }
    
    @IBAction func didTapAdd(_ sender: UIButton) {
        viewModel.didTapAdd()
        prepareButton()
    }
}

extension ItemDetailsViewController {
    @objc func didTapBack() {
        viewModel.triggerSave.accept(true)
    }
}
