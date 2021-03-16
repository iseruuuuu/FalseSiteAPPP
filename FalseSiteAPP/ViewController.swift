//
//  ViewController.swift
//  FalseSiteAPP
//
//  Created by  on 2021/02/28.
//
// private

/*
 
 shearchBarをしっかりできるようにする。 ->済み
 データの追加（URLを取得）　＝＞済み
 Realmを使用して記録する。 =>済み
 tableviewを作成する。　＝＞済み
 保存する。。　＝＞済み
 
 
 
見えないボタンを押すことでページが変わるようにしたい。　＝＞済み
 
 
 */


import UIKit
import WebKit
import RealmSwift


class ViewController: UIViewController,WKNavigationDelegate,UISearchBarDelegate {
    var webView = WKWebView()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bookmark: UIBarButtonItem!
    @IBOutlet weak var switch1: UIBarButtonItem!
    @IBOutlet weak var switch2: UIBarButtonItem!
    @IBOutlet weak var open: UIBarButtonItem!
    
    
    var set:Bool = false
    var set2:Bool = false
    var set3:Bool = false
    var set4:Bool = false
    var set5:Bool = false
    
    
    var move:Bool = false
    
    let realm = try! Realm()
    var itemList:Results<TodoItem>!
    
    var website = String()
    
    // ホームページのURL。起動時にこのページを開く
    let homeUrl = "https://www.google.co.jp"
    // 検索機能で使うURL
    let searchUrl = "https://www.google.co.jp/search?q="
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ホームページを開く
        openUrl(urlString: homeUrl)
        webView.navigationDelegate = self
        searchBar.delegate = self
        indicator.isHidden = true
        //これではられる。
        view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: searchBar.frame.size.height + 50, width: view.frame.size.width, height: view.frame.size.height - toolBar.frame.size.height * 3.8)
        //フリップについて
        webView.allowsBackForwardNavigationGestures = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale: Locale.current)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if website == "" {
        }else{
            //urlが保存したものになる。
            let url = website
            openUrl(urlString: url)
            searchBar.resignFirstResponder()
        }
        
        
    }
    
    // 文字列で指定されたURLをWeb Viewを開く
    func openUrl(urlString: String) {
        let url = URL(string: urlString)
        let request = NSURLRequest(url: url!)
        webView.load(request as URLRequest)
    }
    
    
    // 検索ボタンを押下した時に実行されるメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            let url = searchUrl + searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            openUrl(urlString: url)
            searchBar.resignFirstResponder()
        }
    }
    
  
    @IBAction func switch01(_ sender: Any) {
        if set == false {
            move = true
            set = true
            if (set == true && set2 == true && set3 == true && set4 == true && set5 == true){
                move = true
            }
        }
        
    }
    @IBAction func switch02(_ sender: Any) {
        if set2 == false {
            set2 = true
            if (set == true && set2 == true && set3 == true && set4 == true && set5 == true){
                move = true
            }
        }
    }
    
    @IBAction func switch03(_ sender: Any) {
        if set3 == false {
            set3 = true
            if (set == true && set2 == true && set3 == true && set4 == true && set5 == true){
                move = true
            }
        }
    }
    
    
    @IBAction func swicth04(_ sender: Any) {
        if set4 == false {
            set4 = true
            if (set == true && set2 == true && set3 == true && set4 == true && set5 == true){
                move = true
            }
        }
    }
    
    
    
    @IBAction func switch05(_ sender: Any) {
        if set5 == false {
            set5 = true
            if (set == true && set2 == true && set3 == true && set4 == true && set5 == true){
                move = true
            }
        }
    }
    
    
    
    // Web Veiwが読み込みを開始した時に実行されるメソッド
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.alpha = 1
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.alpha = 0
        indicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        indicator.alpha = 1
        indicator.startAnimating()
    }
    
    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
    
    
    @IBAction func forward(_ sender: Any) {
        webView.goForward()
    }
    
    
    @IBAction func reload(_ sender: Any) {
        webView.reload()
        move = false
        set = false
        set2 = false
        set3 = false
        set4 = false
        set5 = false
    }
    
    @IBAction func add(_ sender: Any) {
        //サイトのURLを表示
        // print(webView.url?.absoluteURL as Any)
        // Optional(https://www.forest-auto.com/)
        // print(webView.url!)
        //   https://www.iseki.co.jp/
        
        if move == false {
            //普通のサイトの場合の話！！！
        let dialog = UIAlertController(title: "ブックマークの追加", message: "\(webView.url!)", preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "追加する", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            //サイトを追加する。
            Helper2().save2(site: "\(self.webView.url!)", date: Date())
            //TableViewに値を渡す。
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
            
        dialog.addAction(cancelAction)
        dialog.addAction(defaultAction)
        self.present(dialog, animated: true, completion: nil)
        }else{
            
            
            //隠したいサイトの場合！！！
            let dialog = UIAlertController(title: "秘密ブックマークの追加", message: "\(webView.url!)", preferredStyle: .alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "追加する", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                //サイトを追加する。
                Helper().save(site: "\(self.webView.url!)", date: Date())
                //TableViewに値を渡す。
            })
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                (action: UIAlertAction!) -> Void in
            })
            dialog.addAction(cancelAction)
            dialog.addAction(defaultAction)
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func bookmark(_ sender: Any) {
        // self.performSegue(withIdentifier: "second", sender: nil)
        
        let secondview = self.storyboard?.instantiateViewController(identifier: "second") as! BookMarkViewController
        self.present(secondview, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    @IBAction func open(_ sender: Any) {
        if move == false {
            let nextVC1 = storyboard?.instantiateViewController(identifier: "first")
            self.present(nextVC1!, animated: true, completion: nil)
        }else{
            let nextVC2 = storyboard?.instantiateViewController(identifier: "four")
            self.present(nextVC2!, animated: true, completion: nil)
        }
        
        
    }
    
}
