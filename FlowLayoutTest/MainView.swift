//
//  MainView.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/19.
//

import UIKit

import SnapKit

class MainView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        
        return view
    }()
    
    let mainCollectionView: UICollectionView = {
        
        func createLayout() -> UICollectionViewLayout {
            let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            let layout = UICollectionViewCompositionalLayout.list(using: config)
            
            return layout
        }
        
        let view = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    let settingViewButton: UIButton = {
        let view = UIButton()
        view.setTitle("설정뷰로 이동", for: .normal)
        return view
    }()
    
    override func configureUI() {
        [searchBar, mainCollectionView, settingViewButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        settingViewButton.snp.makeConstraints { make in
            make.top.equalTo(mainCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
    }
}
