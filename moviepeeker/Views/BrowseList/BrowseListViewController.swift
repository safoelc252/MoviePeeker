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
    
    override func prepareDisplay() {
        prepareTableView()
    }
    override func bindDisplay() {
        bindTableView()
        bindIndicator()
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
    
    fileprivate func prepareTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(BrowseListItemCell.nib,
                           forCellReuseIdentifier: BrowseListItemCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    fileprivate func bindTableView() {
        viewModel.dataItems
            .asObservable()
            .bind(to: tableView
                .rx.items(cellIdentifier:BrowseListItemCell.identifier,
                          cellType: BrowseListItemCell.self)) { (row, element, cell) in
                            cell.setData(data: element)
                            cell.selectionStyle = .none
            }.disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: {  indexPath in
                // TODO: Add data to Realm
                self.gotoDetails()
            }).disposed(by: disposeBag)
    }
    fileprivate func bindIndicator() {
        viewModel
            .activityTracker
            .asObservable()
            .bind(to: IndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

extension BrowseListViewController: DashboardDelegate {
    func searchSong(term: String) {
        debugPrint("search: \(term)")
        viewModel.triggerSearch.accept(term)
    }
}
