
//
//  TodoItem.swift
//  EnglishWordRealmAPP
//
//  Created by 井関竜太郎 on 2021/02/18.

import Foundation
import RealmSwift

class TodoItem2:Object {
   
    @objc dynamic var id2 = ""
    @objc dynamic var site2 = ""
    @objc dynamic var date2 = Date()
    
    override static func primaryKey() -> String? {
        return "id2"
    }
}

