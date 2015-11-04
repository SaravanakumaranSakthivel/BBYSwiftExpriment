//
//  PDPViewController.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 01/11/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

import UIKit

class PDPViewController: UIViewController {
    
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var skuLbl:UILabel!
    @IBOutlet var salePriceLbl: UILabel!
    @IBOutlet var desLbl: UILabel!
    
    var pdpObj: ProductDetail!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI()
    {
        self.nameLbl?.numberOfLines = 0
        self.desLbl?.numberOfLines = 0
        self.salePriceLbl?.numberOfLines = 0

        self.nameLbl.font = UIFont.boldSystemFontOfSize(20.0)
        self.salePriceLbl.textColor = UIColor.redColor()
        
        let salePrice: String = String(format:"Sale Price - %@",self.pdpObj.salePrice)
        let skuStr: String = String(format:"SKU - %@",self.pdpObj.sku)
            
        self.nameLbl?.text = self.pdpObj.name
        self.desLbl?.text = self.pdpObj.longDes
        self.skuLbl?.text = skuStr
        self.salePriceLbl?.text = salePrice
        
        
        if let url = NSURL(string: pdpObj.image) {
            if let data = NSData(contentsOfURL: url){
                self.productImg?.contentMode = UIViewContentMode.ScaleToFill
                self.productImg?.image = UIImage(data: data)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
