//
//  BookMarkViewController.swift
//  FalseSiteAPP
//
//  Created by 井関竜太郎 on 2021/03/01.
//

import UIKit
import RealmSwift

class BookMarkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var itemList:Results<TodoItem>!
    var token:NotificationToken!
    
    
    var resultHandler: ((String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemList = realm.objects(TodoItem.self).sorted(byKeyPath: "date")
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
            Helper().deleteItem(item: itemList[indexPath.row], token: token)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = storyboard?.instantiateViewController(identifier: "next") as! ViewController
        let item = itemList[indexPath.row]
        next.website = item.site
         navigationController?.pushViewController(next, animated: true)
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = itemList[indexPath.row]
        cell?.selectionStyle = .none
        cell?.textLabel?.text = item.site
        cell?.detailTextLabel?.text = Helper().deteToString(date: item.date)
        return cell!
    }
    
    
}
