
//
//  TodoItem.swift
//  EnglishWordRealmAPP
//
//  Created by 井関竜太郎 on 2021/02/18.
//

import Foundation
import RealmSwift

class TodoItem:Object {
   
    @objc dynamic var id = ""
    @objc dynamic var site = ""
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
