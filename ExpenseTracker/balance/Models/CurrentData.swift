//
//  CurentData.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class CurrentData {
    var id : Int
    var categoryId : String = ""
    var date : String = ""
    var amount : String = ""
    var isIncome : Bool
    init(id : Int,categoryId:String, date : String, amount : String, isIncome : Bool) {
        self.categoryId = categoryId
        self.date = date
        self.amount = amount
        self.isIncome = isIncome
        self.id = id
    }
}
