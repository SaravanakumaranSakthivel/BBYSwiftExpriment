//
//  SubCategoryViewController.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 30/10/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet
    var tableView: UITableview!
    
    var catIdVal: NSString!
    var dataSource: NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        dataSource = NSMutableArray()
        getSubCategories()
        
    }
    
    func getSubCategories() {
        let urlStr = NSString(format:"http://api.bestbuy.com/v1/categories(id=%@)?format=json&apiKey=3hpgqx2yz9f8tcrvf2934hua&show=subCategories",catIdVal)
        NSLog("Subcatgory url ------ %@", urlStr)

        let url = NSURL(string: urlStr as String)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler:{
                                                    data,
                                                    urlResponse,
                                                    error -> Void  in
            
            if(error != nil){
                NSLog("Error Des ------- %@", error!.localizedDescription)
            }
            
            let resDic:NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            
            let catArr: NSArray! = resDic.objectForKey("categories") as! NSArray
            
            let subCatDic : NSDictionary! = catArr.objectAtIndex(0) as! NSDictionary
            let subCatArr : NSArray! = subCatDic.objectForKey("subCategories") as! NSArray
            
            
            for var index=0 ; index<subCatArr?.count; index++ {
                let dic:NSDictionary! = subCatArr?.objectAtIndex(index) as! NSDictionary
                let tempSubCat:SubCategory = SubCategory(idVal:dic.objectForKey("id") as! String, name: dic.objectForKey("name") as! String)
                self.dataSource.addObject(tempSubCat)
            }
            
            NSLog("Actual Subcat ====== %@", self.dataSource)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        })
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let tempSubCat:SubCategory = dataSource.objectAtIndex(indexPath.row) as! SubCategory
        cell.textLabel?.text = tempSubCat.name
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
