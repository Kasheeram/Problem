//
//  Model.swift
//  ZopSmartProblem
//
//  Created by kashee on 15/01/19.
//  Copyright © 2019 kashee. All rights reserved.
//

import UIKit

class CategoryDetails:NSObject {
    var name:String?
    var imageUrl:[String]?
    
    func initDic(result:NSDictionary) {
        name = result["name"] as? String
        imageUrl = result["images"] as? Array
    }
}
