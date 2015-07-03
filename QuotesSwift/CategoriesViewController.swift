//
//  CategoriesViewController.swift
//  QuotesSwift
//
//  Created by Terry Bu on 7/3/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoriesViewController: UITableViewController {

    var allCategories: JSON?
    
    override func viewDidLoad() {
        //        let url = NSURL(string: "http://www.stackoverflow.com")
        //
        //        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        //        }
        //
        //        task.resume()
        
        Alamofire.request(.GET, "http://terrysquotes.herokuapp.com/category.json", parameters: nil)
            .responseSwiftyJSON({ (request, response, jsonAllCategories, error) in
                self.allCategories = jsonAllCategories
                self.tableView.reloadData()
                
                if error != nil {
                    println(error)
                }
            })
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let json = allCategories {
            return json.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell3") as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell3")
        }
        
        cell!.textLabel!.text = allCategories![indexPath.row].string
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "singleCategoryVCSegue") {
            var destination = segue.destinationViewController as! SingleCategoryViewController
            var selectCategory = allCategories![tableView.indexPathForSelectedRow()!.row].string
            destination.category = selectCategory
        }
    }

    
}
