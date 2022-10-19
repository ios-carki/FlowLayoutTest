//
//  FlowLayoutCollectionViewController.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/18.
//

import UIKit

import RealmSwift

struct User {
    let name: String
    let age: Int
}

class FlowLayoutCollectionViewController: UICollectionViewController {
    
    var list = [
        User(name: "뽀로로", age: 3),
        User(name: "에디", age: 13),
        User(name: "해리포터", age: 33),
        User(name: "도라에몽", age: 5)
    ]
    
    let localeRealm = try! Realm()
    var tasks: Results<Todo>!
    
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    var cellRegisteration2: UICollectionView.CellRegistration<UICollectionViewListCell, User>!

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
            
            if indexPath.section == 0 {
                content.image = UIImage(systemName: "person.fill")
                content.imageProperties.tintColor = .orange
                content.text = itemIdentifier.title
                content.textProperties.color = .brown

                content.secondaryText = itemIdentifier.detail

            }
            
            cell.contentConfiguration = content //UIContentConfiguration
        })
        
        cellRegisteration2 = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content2 = cell.defaultContentConfiguration()
            content2.text = itemIdentifier.name
            
            content2.secondaryText = "\(itemIdentifier.age)살"
            cell.contentConfiguration = content2 //UIContentConfiguration
        })
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return tasks.count
        } else {
            return list.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let item = tasks[indexPath.item]
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
            
            return cell
        } else {
            let item2 = list[indexPath.item]
            let cell2 = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration2, for: indexPath, item: item2)
            return cell2
        }
    }

    
    
}
