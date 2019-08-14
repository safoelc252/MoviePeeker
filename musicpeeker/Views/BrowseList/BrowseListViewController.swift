//
//  BrowseListViewController.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 07/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BrowseListViewController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let viewModel = BrowseListViewModel()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        viewModel.triggerSearch.accept("true")
//    }
    
    override func prepareDisplay() {
        prepareTableView()
    }
    override func bindDisplay() {
        bindTableView()
    }
    override func bindViewModel() {
        let input = BrowseListViewModel.Input(loadSearch: viewModel.triggerSearch.asDriver())
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
        tableView.register(BrowseListItemCell.nib,
                           forCellReuseIdentifier: BrowseListItemCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    private func bindTableView() {
        viewModel.dataItems
            .asObservable()
            .bind(to: tableView
                .rx.items(cellIdentifier:BrowseListItemCell.identifier,
                          cellType: BrowseListItemCell.self)) { (row, element, cell) in
                            cell.setData(data: element)
                            cell.selectionStyle = .none
            }.disposed(by: disposeBag)

//        tableViewRunners.rx.itemSelected
//            .subscribe(onNext: { indexPath in
//                let publicID = self.viewModel.dataRunners.value[indexPath.row].publicID ?? 0
//                self.gotoUser(publicID: publicID)
//            }).disposed(by: disposeBag)
        
    }
}

extension BrowseListViewController: DashboardDelegate {
    func searchSong(term: String) {
        debugPrint("search: \(term)")
        viewModel.triggerSearch.accept(term)
    }
}
