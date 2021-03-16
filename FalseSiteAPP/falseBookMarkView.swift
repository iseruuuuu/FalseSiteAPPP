
//
//  nexttViewController.swift
//  FalseSiteAPP
//
//  Created by 井関竜太郎 on 2021/03/04.
//

import UIKit
import RealmSwift

class falseBookMarkView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var itemList:Results<TodoItem2>!
    var token:NotificationToken!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemList = realm.objects(TodoItem2.self).sorted(byKeyPath: "date2")
        token = realm.observe { notification,realm in
            self.tableView.reloadData()
        }
        tableView.deleteRows(at: [], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Helper2().deleteItem2(item: itemList[indexPath.row], token: token)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = storyboard?.instantiateViewController(identifier: "next") as! ViewController
        let item = itemList[indexPath.row]
        next.website = item.site2
         navigationController?.pushViewController(next, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
        let item = itemList[indexPath.row]
        cell?.selectionStyle = .none
        cell?.textLabel?.text = item.site2
        cell?.detailTextLabel?.text = Helper().deteToString(date: item.date2)
        return cell!
    }
    
    
}
