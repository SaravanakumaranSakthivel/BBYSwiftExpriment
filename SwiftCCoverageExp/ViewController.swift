//
//  ViewController.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 25/10/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet
    var tableView: UITableView!
    var datasoruce: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datasoruce = NSMutableArray()
        getCategories() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getCategories() {
        
        let urlPath = "http://api.bestbuy.com/v1/categories?format=json&apiKey=3hpgqx2yz9f8tcrvf2934hua&show=id,name,active"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data,
            response,
            error -> Void in
            
            if (error != nil)
            {
                print("error ====== %@",error?.localizedDescription)
            }
            
            
            let resultDic: NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            let catArr: NSArray! = resultDic.valueForKey("categories") as! NSArray

            for var index = 1; index < catArr.count; index++
            {
                let tempDic: NSDictionary! = catArr.objectAtIndex(index) as! NSDictionary
                let tempCat: Category = Category(idVal:tempDic.objectForKey("id") as! String, name: tempDic.objectForKey("name") as! String, active:tempDic.objectForKey("active") as! Bool)
                self.datasoruce.addObject(tempCat)
            }
            NSLog("Data Souce ===== %@",self.datasoruce)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        })
        task.resume()
        
    }
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasoruce.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "categoryCell")
        
        let tempCat:Category = datasoruce.objectAtIndex(indexPath.row) as! Category
        cell.textLabel?.text = tempCat.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let catObj:Category = datasoruce.objectAtIndex(indexPath.row) as! Category
        
        let subCatViewCtrl:SubCatViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("subCatViewCtrl") as! SubCatViewController
        subCatViewCtrl.catIdVal = catObj.idVal
        self.navigationController?.pushViewController(subCatViewCtrl, animated:true)
    }

}

