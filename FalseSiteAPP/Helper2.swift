//
//  Helper.swift
//  FalseSiteAPP
//
//  Created by 井関竜太郎 on 2021/03/01.
//

import Foundation
import RealmSwift

class Helper2 {
    let realm = try! Realm()
   
    func save2(site:String,date:Date) {
        
        let item2 = TodoItem2()
        item2.site2 = site
        item2.id2 = String(Int.random(in: 0...9999))
        try! realm.write{
            realm.add(item2)
        }
    }
    
    func deteToString2(date:Date) ->String {
        let formatter2 = DateFormatter()
        //  formatter.dateFormat = "MM/dd HH:mm"
        formatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "MM/dd", options: 0, locale: Locale.current)
        return formatter2.string(from:date)
    }
    
    
    func deleteItem2(item:TodoItem2,token:NotificationToken) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id2])
        try! realm.write(withoutNotifying: [token]) {
            realm.delete(item)
        }
    }
    
}
