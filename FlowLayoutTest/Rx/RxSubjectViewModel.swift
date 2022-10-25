//
//  RxSubjectViewModel.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/25.
//

import UIKit

import RxSwift

struct Contact {
    var name: String
    var age: Int
    var address: String
}

class RxSubjectViewModel: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = RxSubjectViewModel()
    
    var contactData = [
        Contact(name: "Father", age: 21, address: "Seoul in Korea"),
        Contact(name: "Mother", age: 23, address: "Seoul in Korea"),
        Contact(name: "Sister", age: 25, address: "Seoul in Korea"),
        Contact(name: "Friend1", age: 21, address: "Seoul in Korea"),
        Contact(name: "Friend2", age: 21, address: "Seoul in Korea")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func navigationSetting(view: UIViewController) {
        let resetButton = UIBarButtonItem(title: "리셋", style: .plain, target: self, action: #selector(resetData))
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(fetchData))
        let newContactButton = UIBarButtonItem(title: "새로운 연락처", style: .plain, target: self, action: #selector(newData))
        
        view.navigationItem.leftBarButtonItem = newContactButton
        view.navigationItem.rightBarButtonItems = [addButton, resetButton]
        
//        addButton.rx.tap
//            .withUnretained(self)
//            .subscribe { (vc, _) in
//                vc.viewModel.fetchData()
//            }
//            .disposed(by: disposeBag)
//
//        resetButton.rx.tap // tap = touchupinside
//            .withUnretained(self)
//            .subscribe { (vc, _) in
//                vc.viewModel.resetData()
//            }
//            .disposed(by: disposeBag)
//
//        newContactButton.rx.tap
//            .withUnretained(self)
//            .subscribe { (vc, _) in
//                vc.viewModel.newData()
//            }
//            .disposed(by: disposeBag)
    }
    
    func searchBarSetting(searchBarName: UISearchBar) {
//        searchBarName.rx.text.orEmpty
//            .withUnretained(self)
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) //구독 시점에 타이밍 걸어줌 - 기다리는 코드
//        //.distinctUntilChanged() // 같은 값은 받지 않음.
//            .subscribe { (vc, value) in
//                print("=====\(value)")
//                vc.viewModel.filterData(query: value)
//            }
//            .disposed(by: disposeBag)
    }
    
    func listSetting() {
        var tableView = RxSubjectView().tableView
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.name): \(element.age)세 (\(element.address))"
            }
            .disposed(by: disposeBag)
    }
    
    @objc func fetchData() {
        list.onNext(contactData)
    }
    
    @objc func resetData() {
        list.onNext([])
    }
    
    @objc func newData() {
        let new = Contact(name: "Friend \(Int.random(in: 1...100))", age: Int.random(in: 10...30), address: "Seould in Korea")
        contactData.append(new)
        list.onNext(contactData)
    }
    
    @objc func filterData(query: String) {
        
        let result = query != "" ? contactData.filter { $0.name.contains(query) } : contactData
        list.onNext(result)
    }
    
    func tableViewSetting(tableViewName: UITableView, cellIdentifier: String) {
        tableViewName.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
