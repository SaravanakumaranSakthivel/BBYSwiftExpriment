//
//  Category.swift
//  SwiftCCoverageExp
//
//  Created by SaravanaKumaran Sakthivel on 25/10/15.
//  Copyright © 2015 MutharPadi. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var idVal :String
    var name: String
    var active: Bool
    
    init(idVal: String, name: String, active: Bool) {
        
        self.idVal = idVal
        self.name = name
        self.active = active
        
//        if(idVal == nil || name == nil || active==nil){
//            return nil
//  
//        }
    }
}