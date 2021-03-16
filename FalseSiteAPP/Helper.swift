//
//  Helper.swift
//  FalseSiteAPP
//
//  Created by 井関竜太郎 on 2021/03/01.
//

import Foundation
import RealmSwift

class Helper {
    let realm = try! Realm()
   

    func save(site:String,date:Date) {
        
        let item = TodoItem()
        item.site = site
        item.id = String(Int.random(in: 0...9999))
        try! realm.write{
            realm.add(item)
        }
    }
    
    func deteToString(date:Date) ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MM/dd", options: 0, locale: Locale.current)
        return formatter.string(from:date)
    }
    
    
    func deleteItem(item:TodoItem,token:NotificationToken) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
        try! realm.write(withoutNotifying: [token]) {
            realm.delete(item)
        }
    }
    
}
