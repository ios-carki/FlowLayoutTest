//
//  SettingView.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/19.
//

import UIKit

import SnapKit

class SettingView: BaseView {
    
    let setCollectionView: UICollectionView = {
        func createLayout() -> UICollectionViewLayout {
            let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            let layout = UICollectionViewCompositionalLayout.list(using: config)
            
            return layout
        }
        
        let view = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    override func configureUI() {
        self.addSubview(setCollectionView)
    }
    
    override func setConstraints() {
        setCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
