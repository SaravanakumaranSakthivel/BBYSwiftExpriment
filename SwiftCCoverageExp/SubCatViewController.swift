//
//  SubCatViewController.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 31/10/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

import UIKit

class SubCatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    
    var catIdVal: NSString!
    var dataSource: NSMutableArray!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        dataSource = NSMutableArray()
        getSubCategories()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "categoryCell")
        let tempSubCat:SubCategory = dataSource.objectAtIndex(indexPath.row) as! SubCategory
        cell.textLabel?.text = tempSubCat.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let productListVC:ProductListViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("productlist") as! ProductListViewController
        self.navigationController?.pushViewController(productListVC, animated:true)
    }

}
