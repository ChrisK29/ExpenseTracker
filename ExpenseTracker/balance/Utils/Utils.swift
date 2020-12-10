//
//  Utils.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
class Utils {
    
    let formatter = DateFormatter()
    var calendar = Calendar.autoupdatingCurrent
    
    var categoryList = [Category(id: "0", name: "Travel", image: UIImage(named: "travel") ?? UIImage(),isIncome: false),Category(id: "1", name: "Food", image: UIImage(named: "food") ?? UIImage(),isIncome: false),Category(id: "2", name: "Health", image: UIImage(named: "health") ?? UIImage(),isIncome: false),Category(id: "3", name: "Groceries", image: UIImage(named: "groceries") ?? UIImage(),isIncome: false),Category(id: "4", name: "Clothes", image: UIImage(named: "clothes") ?? UIImage(),isIncome: false),Category(id: "6", name: "Salary", image: UIImage(named: "salary") ?? UIImage(),isIncome: true)]
    
    
    func getCategory(categoryId : String) -> Category{
        if let category = categoryList.first(where: {$0.id.elementsEqual(categoryId)}){
            return category
        }
        return categoryList[0]
    }
    
    func getPosition(categoryId : String) -> Int{
      
        if let position = categoryList.firstIndex(where: {$0.id.elementsEqual(categoryId)}){
                return position
        }
        return 0
    }
    
    func dateTimeToString(dateString : String) -> String{
        
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "EEEE d MMM"
        return formatter.string(from: date ?? Date())
    }
    
    func dateTimeToMonthString(dateString : String) -> String{
           
           formatter.dateFormat = "dd-MM-yyyy"
           let date = formatter.date(from: dateString)
           formatter.dateFormat = "MMMM yyyy"
           return formatter.string(from: date ?? Date())
       }
       
    
    
    func getMonth(dateString : String) -> String{
        
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "MM"
        return formatter.string(from: date ?? Date())
    }
    
    func getYear(dateString : String) -> String{
        
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date ?? Date())
    }
    
    
    
    func currentMonth(date : Date) -> String{
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    
    
    func currentDay() -> String{
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: Date())
    }
    
    func getCategoryListSpinner() -> [String]{
        return categoryList.map({$0.name})
    }
    
    func getCategoryListIdSpinner() -> [String]{
        return categoryList.map({$0.id})
    }
    
}
