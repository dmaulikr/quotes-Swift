//
//  SingleCategoryViewController.swift
//  QuotesSwift
//
//  Created by Terry Bu on 7/3/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SingleCategoryViewController: UITableViewController {
    
    var category: String?
    var categoryQuotes: JSON?
    var alertController: UIAlertController?
    
    override func viewDidLoad() {

        
        if let myCategory = category {
            var urlString = "http://terrysquotes.herokuapp.com/category/\(myCategory).json"
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! //this is needed because otherwise, author string with spaces like "Tony Robbins" will cause a crash. We instead need to send something like %20 for spaces
            Alamofire.request(.GET, urlString, parameters: nil)
                .responseSwiftyJSON({ (request, response, jsonQuotesByCategory, error) in
                    println(jsonQuotesByCategory)
                    self.categoryQuotes = jsonQuotesByCategory
                    self.tableView.reloadData()
                    
                    if error != nil {
                        println(error)
                    }
                })
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let quotes = self.categoryQuotes {
            return quotes.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell4") as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell4")
        }
        
        var quoteObject =  categoryQuotes![indexPath.row]
        cell!.textLabel!.text = quoteObject["quotetext"].string
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var quoteObject =  categoryQuotes![indexPath.row]
        var quoteText = quoteObject["quotetext"].string
        
        alertController = UIAlertController(title: quoteObject["author"].string, message: quoteText, preferredStyle: UIAlertControllerStyle.Alert)
        var action = UIAlertAction(title: "Read it", style: UIAlertActionStyle.Default, handler: nil)
        alertController!.addAction(action)
        presentViewController(alertController!, animated: false, completion:nil)
    }
}
