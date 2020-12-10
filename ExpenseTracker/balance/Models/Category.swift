//
//  Category.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
class Category{
    var id : String 
    var name : String
    var image : UIImage
    var isIncome : Bool
    init(id:String, name:String,image:UIImage, isIncome : Bool) {
        self.id = id
        self.name = name
        self.image = image
        self.isIncome = isIncome
    }
}
