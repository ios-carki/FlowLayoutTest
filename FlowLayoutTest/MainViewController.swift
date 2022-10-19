//
//  MainViewController.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/19.
//

import UIKit

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    var list = ["삼성", "이재용", "애플", "스티브 잡스", "팀 쿡", "조나단 아이브", "토스", "이승건"]
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        mainView.mainCollectionView.collectionViewLayout = createLayout()
        configureDataSourece()
        
        mainView.mainCollectionView.delegate = self
        mainView.searchBar.delegate = self
        
        mainView.settingViewButton.addTarget(self, action: #selector(gotoSettingView), for: .touchUpInside)
    }
    
    @objc func gotoSettingView() {
        let vc = SettingViewController()
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let alert = UIAlertController(title: item, message: "클릭", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapShot = dataSource.snapshot()
        snapShot.appendItems([searchBar.text!])
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension MainViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    private func configureDataSourece() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.secondaryText = "\(itemIdentifier.count)"
            cell.contentConfiguration = content
            
            var backGround = UIBackgroundConfiguration.listPlainCell()
            backGround.strokeWidth = 2
            backGround.strokeColor = .black
            cell.backgroundConfiguration = backGround
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.mainCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([0])
        snapShot.appendItems(list)
        dataSource.apply(snapShot)
    }
}
