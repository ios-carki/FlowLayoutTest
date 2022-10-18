//
//  Todo.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/18.
//

import Foundation

import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var detail: String
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(title: String, detail: String) {
        self.init()
        self.title = title
        self.detail = detail
    }
}
