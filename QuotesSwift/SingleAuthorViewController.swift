//
//  SingleAuthorViewController.swift
//  QuotesSwift
//
//  Created by Terry Bu on 7/3/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SingleAuthorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var author: String?
    var authorsQuotes: JSON?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        if let myAuthor = author {
            var urlString = "http://terrysquotes.herokuapp.com/authors/\(myAuthor).json"
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! //this is needed because otherwise, author string with spaces like "Tony Robbins" will cause a crash. We instead need to send something like %20 for spaces
            Alamofire.request(.GET, urlString, parameters: nil)
                .responseSwiftyJSON({ (request, response, jsonQuotesByAuthor, error) in
                    println(jsonQuotesByAuthor)
                    self.authorsQuotes = jsonQuotesByAuthor
                    self.tableView.reloadData()
                    
                    if error != nil {
                        println(error)
                    }
                })
        }
        

        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let quotes = self.authorsQuotes {
            return quotes.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell2") as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell2")
        }
        
        var quoteObject =  authorsQuotes![indexPath.row]
        cell!.textLabel!.text = quoteObject["quotetext"].string
        return cell!
    }
    
    
}
