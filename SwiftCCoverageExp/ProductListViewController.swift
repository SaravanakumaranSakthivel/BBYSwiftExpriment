//
//  ProductListViewController.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 31/10/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

//http://api.bestbuy.com/v1/products(longDescription=iPhone*%7Csku=7619002)?show=sku,name&pageSize=15&page=5&apiKey=3hpgqx2yz9f8tcrvf2934hua&format=json

import UIKit

class ProductListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    var datasoruce: NSMutableArray!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.rowHeight = 100;
        self.tableView.estimatedRowHeight = 70

        // Do any additional setup after loading the view.
        datasoruce = NSMutableArray()
        getProductList()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductList ()
    {
        let urlPath = "http://api.bestbuy.com/v1/products(search=camera)?show=name,sku,image,salePrice,longDescription,image&format=json&apiKey=3hpgqx2yz9f8tcrvf2934hua"
        
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
            let catArr: NSArray! = resultDic.valueForKey("products") as! NSArray
            
            for var index = 1; index < catArr.count; index++
            {
                let tempDic: NSDictionary! = catArr.objectAtIndex(index) as! NSDictionary
                
                let skuVal:NSNumber! = tempDic.objectForKey("sku") as! NSNumber
                let salePriceVal:Double = tempDic.objectForKey("salePrice") as! Double

                let productDetail: ProductDetail = ProductDetail(name:tempDic.objectForKey("name") as! String,
                    sku:skuVal.stringValue,
                    image:tempDic.objectForKey("image") as! String,
                    longDes:tempDic.objectForKey("longDescription") as! String,
                    salePrice:String(format: "%.2f",salePriceVal))
                
                self.datasoruce.addObject(productDetail)
            }
            NSLog("Data Souce ===== %@",self.datasoruce)
            
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datasoruce.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "productList")
        let productDetail:ProductDetail = self.datasoruce.objectAtIndex(indexPath.row) as! ProductDetail
        cell.textLabel?.text = productDetail.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = productDetail.salePrice
        cell.detailTextLabel?.textColor = UIColor.redColor()
        cell.detailTextLabel?.backgroundColor = UIColor.redColor()
        if let url = NSURL(string: productDetail.image) {
            if let data = NSData(contentsOfURL: url){
                cell.imageView?.contentMode = UIViewContentMode.ScaleToFill
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let prodDetail: ProductDetail! = self.datasoruce.objectAtIndex(indexPath.row) as! ProductDetail
        
        let pdbViewCtrl: PDPViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pdpviewcontrol") as! PDPViewController
        pdbViewCtrl.pdpObj = prodDetail
        self.navigationController?.showViewController(pdbViewCtrl, sender: self)
        
//        let productListVC:ProductListViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("productlist") as! ProductListViewController
//        self.navigationController?.pushViewController(productListVC, animated:true)
    }
    


}
