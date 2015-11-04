//
//  ProductDetail.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 31/10/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

import UIKit

class ProductDetail: NSObject {

    var name :String
    var sku: String
    var image: String
    var longDes: String
    var salePrice: String
    
    init(name: String, sku: String, image: String, longDes:String, salePrice:String) {
        
        self.sku = sku
        self.name = name
        self.longDes = longDes
        self.salePrice = salePrice
        self.image = image
        
        //        if(idVal == nil || name == nil || active==nil){
        //            return nil
        //
        //        }
    }

}
