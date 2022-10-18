//
//  FlowLayoutCollectionViewController.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/18.
//

import UIKit

import RealmSwift

class FlowLayoutCollectionViewController: UICollectionViewController {
    
    let localeRealm = try! Realm()
    var tasks: Results<Todo>!
    
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("File URL: ", localeRealm.configuration.fileURL!)
        
        //2. 스키마 버전
        do {
            let version = try schemaVersionAtURL(localeRealm.configuration.fileURL!)
            print("스키마 버전: ", version)
        } catch {
            print(error)
        }
        
        tasks = localeRealm.objects(Todo.self)
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = cell.defaultContentConfiguration() //UIListContentConfiguration
            content.image = UIImage(systemName: "person.fill")
            content.imageProperties.tintColor = .orange
            
            content.text = itemIdentifier.title
            content.textProperties.color = .brown
            
            content.secondaryText = itemIdentifier.detail
            
            cell.contentConfiguration = content //UIContentConfiguration
        })

//        for i in 1...10 {
//            let task = Todo(title: "테스트 번호 \(i)", detail: "테스트 번호 \(i)번의 디테일")
//
//            try! localeRealm.write {
//                localeRealm.add(task)
//            }
//        }
        
        
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        
        return cell
    }

    
    
}
