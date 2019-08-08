//
//  DashboardViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardViewController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let viewModel = DashboardViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.triggerSearch.accept(true)
    }
    
    override func prepareDisplay() {
        prepareTableView()
    }
    override func bindDisplay() {
        bindTableView()
    }
    override func bindViewModel() {
        let input = DashboardViewModel.Input(loadSearch: viewModel.triggerSearch.asDriver())
        let output = viewModel.transform(input: input)
        output.error
            .drive(Binder.init(self,
                               binding: viewModel.bindError))
            .disposed(by: disposeBag)
        output.searchItems
            .drive(Binder.init(self,
                               binding: viewModel.bindSearch))
            .disposed(by: disposeBag)
    }
    
    private func prepareTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(DashboardItemCell.nib,
                           forCellReuseIdentifier: DashboardItemCell.identifier)
    }
    private func bindTableView() {
        viewModel.dataItems
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier:DashboardItemCell.identifier,
                                         cellType: DashboardItemCell.self)) { (row, element, cell) in
                cell.setData(data: element)
            }.disposed(by: disposeBag)

//        tableViewRunners.rx.itemSelected
//            .subscribe(onNext: { indexPath in
//                let publicID = self.viewModel.dataRunners.value[indexPath.row].publicID ?? 0
//                self.gotoUser(publicID: publicID)
//            }).disposed(by: disposeBag)
        
    }
}
