//
//  HomeViewController.swift
//  QuotesSwift
//
//  Created by Terry Bu on 7/3/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var allAuthorsJSON: JSON?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        //        let url = NSURL(string: "http://www.stackoverflow.com")
        //
        //        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        //        }
        //
        //        task.resume()
        
        Alamofire.request(.GET, "http://terrysquotes.herokuapp.com/authors.json", parameters: nil)
            .responseSwiftyJSON({ (request, response, jsonAllAuthors, error) in
                println(jsonAllAuthors)
                self.allAuthorsJSON = jsonAllAuthors
                self.tableView .reloadData()
                
                if error != nil {
                    println(error)
                }
            })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let json = allAuthorsJSON {
            return allAuthorsJSON!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        cell!.textLabel!.text = allAuthorsJSON![indexPath.row].string
        
        return cell!
    }
    
    
}
