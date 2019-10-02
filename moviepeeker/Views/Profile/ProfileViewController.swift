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
import ActionSheetPicker_3_0

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
        bindPickers()
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
        textFieldGender.text = viewModel.userProfile.gender ?? "Male"
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
    
    fileprivate func bindPickers() {
        textFieldAge
            .rx.controlEvent(.editingDidBegin)
            .asObservable()
            .bind(onNext: {
                self.view.endEditing(true)
                guard !self.viewModel.ageList.value.isEmpty else { return }
                let doneBlk:ActionStringDoneBlock = { (picker, row, data) in
                    guard !self.viewModel.ageList.value.isEmpty else { return }
                    self.textFieldAge.text = "\(self.viewModel.ageList.value[row])"
                    self.textFieldAge.sendActions(for: .editingChanged)
                }
                let cancelBlk:ActionStringCancelBlock = { _ in }
                let pickerAge = ActionSheetStringPicker(title: "",
                                                        rows: self.viewModel.ageList.value,
                                                        initialSelection: 0,
                                                        doneBlock: doneBlk,
                                                        cancel: cancelBlk,
                                                        origin: self.view)
                pickerAge?.show()
            }).disposed(by: disposeBag)
        
        textFieldGender
            .rx.controlEvent(.editingDidBegin)
            .asObservable()
            .bind(onNext: {
                self.view.endEditing(true)
                guard !self.viewModel.genderList.value.isEmpty else { return }
                let doneBlk:ActionStringDoneBlock = { (picker, row, data) in
                    guard !self.viewModel.genderList.value.isEmpty else { return }
                    self.textFieldGender.text = "\(self.viewModel.genderList.value[row])"
                    self.textFieldGender.sendActions(for: .editingChanged)
                }
                let cancelBlk:ActionStringCancelBlock = { _ in }
                let pickerGender = ActionSheetStringPicker(title: "",
                                                           rows: self.viewModel.genderList.value,
                                                           initialSelection: 0,
                                                           doneBlock: doneBlk,
                                                           cancel: cancelBlk,
                                                           origin: self.view)
                pickerGender?.show()
            }).disposed(by: disposeBag)
    }
}

extension ProfileViewController: ProfileDelegate {
    func didTapSave() {
        textFieldName.resignFirstResponder()
        saveData()
    }
    
    func saveData() {
        viewModel.userProfile.displayName = textFieldName.text
        viewModel.userProfile.age  = Int(textFieldAge.text ?? "1")
        viewModel.userProfile.gender = textFieldGender.text
        viewModel.triggerSave.accept(true)
    }
}
