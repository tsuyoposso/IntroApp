
//
//  Page1TViewController.swift
//  IntroApp
//
//  Created by 長坂豪士 on 2019/10/21.
//  Copyright © 2019 NagaKe. All rights reserved.
//

import UIKit
import SegementSlide

class Page3ViewController: UITableViewController, SegementSlideContentScrollViewDelegate, XMLParserDelegate {

    
    // XMLParserのインスタンスを作成
    var parser = XMLParser()
    
    // RSSのパース内の現在の要素名
    var currentElementName: String!
    
    var newsItems = [NewsItems]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .clear
        // 画像をtableViewの下に置く
        
        let image = UIImage(named: "2")
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height)
        
        imageView.image = image
        self.tableView.backgroundView = imageView
        
        // XMLパース
        let urlString = "https://news.yahoo.co.jp/pickup/rss.xml"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
    }
    
    @objc var scrollView: UIScrollView {
        return tableView
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // スタイルを変更した書き方、２行にする
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        cell.backgroundColor = .clear
        
        let newsItem = self.newsItems[indexPath.row]
        
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white

        return cell
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        if elementName == "item" {
            
            self.newsItems.append(NewsItems())
            
        } else {
            
            currentElementName = elementName
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.newsItems.count > 0 {
            
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            switch self.currentElementName {
                
            case "title":
                lastItem.title = string
            
            case "link":
                lastItem.url = string
                
            case "pubDate":
                lastItem.pubDate = string
                
            default: break
                
            }
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //WebViewControllerにurlを渡して、表示したい
        let webViewController = WebViewController()
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
