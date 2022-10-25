//
//  RxSubjectViewController.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/25.
//

import UIKit

import RxSwift
import RxCocoa

class RxSubjectViewController: UIViewController {
    
    let mainView = RxSubjectView()
    let viewModel = RxSubjectViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.navigationSetting(view: self)
//        viewModel.tableViewSetting(tableViewName: mainView.tableView, cellIdentifier: "Cell")
//        viewModel.searchBarSetting(searchBarName: mainView.searchBar)
        
//        viewModel.list
//            .bind(to: mainView.tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(element.name): \(element.age)세 (\(element.address))"
//            }
//            .disposed(by: disposeBag)
    }
    
    
}
