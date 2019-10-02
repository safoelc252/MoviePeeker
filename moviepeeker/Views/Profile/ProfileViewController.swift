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
import RxSwift
import RxCocoa

protocol ProfileDelegate: class {
    func didTapSave()
}

class ProfileViewController: BaseController {
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.triggerLoad.accept(true)
    }

    override func prepareDisplay() {
        prepareTableView()
    }
    
    override func bindDisplay() {
        bindTableView()
    }
    
    override func bindViewModel() {
        let input = ProfileViewModel.Input(triggerLoad: viewModel.triggerLoad.asDriver(),
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
    
    func prepareData() {
        textFieldName.text = viewModel.userProfile.displayName
        textFieldAge.text = "\(viewModel.userProfile.age ?? 1)"
        textFieldGender.text = viewModel.userProfile.gender ?? ""
        viewModel.favoriteItems.accept(viewModel.userProfile.favoriteItems ?? [])
    }
    func prepareTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(BrowseListItemCell.nib,
                           forCellReuseIdentifier: BrowseListItemCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

    fileprivate func bindTableView() {
        viewModel.favoriteItems
            .asObservable()
            .bind(to: tableView
                .rx.items(cellIdentifier:BrowseListItemCell.identifier,
                          cellType: BrowseListItemCell.self)) { (row, element, cell) in
                          cell.setData(data: element)
                          cell.contentView.backgroundColor = .white
                          cell.selectionStyle = .none
            }.disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe({  indexPath in
                self.gotoDetails(item: self.viewModel.favoriteItems.value[indexPath.element?.row ?? 0])
            }).disposed(by: disposeBag)
    }
}

extension ProfileViewController: ProfileDelegate {
    func didTapSave() {
        saveData()
    }
    
    func saveData() {
        viewModel.userProfile.displayName = textFieldName.text
        viewModel.userProfile.age  = Int(textFieldAge.text ?? "1")
        viewModel.userProfile.gender = textFieldGender.text
        viewModel.triggerSave.accept(true)
    }
}
