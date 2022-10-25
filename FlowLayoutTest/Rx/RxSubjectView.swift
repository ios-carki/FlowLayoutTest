//
//  RxSubjectView.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/25.
//

import UIKit

import SnapKit

class RxSubjectView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    override func configureUI() {
        [searchBar, tableView].forEach{
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
