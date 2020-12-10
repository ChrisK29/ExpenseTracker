//
//  MainViewModel.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
class MainViewModel {
    
    var currentDataList : [CurrentData] = []{
        didSet{
            currentDataListSuccess?()
        }
    }
    
    var incomeData : String = ""{
        didSet{
            incomeDataSuccess?()
        }
    }
    
    var expenseData : String = ""{
        didSet{
            expenseDataSuccess?()
        }
    }
    
    var currentBalanceData : String = ""{
        didSet{
            currentBalanceSuccess?()
        }
    }
    var currentDate = ""
    var currentDataListSuccess : (() -> ())?
    var incomeDataSuccess : (() -> ())?
    var expenseDataSuccess : (() -> ())?
    var currentBalanceSuccess : (() -> ())?
    
    private var income : Float = 0.00
    private var expense : Float = 0.00
    private var sqliteConnection : SqliteConnection!
    func getCurrentData(date : String){
        let month = Utils().getMonth(dateString: date)
        let year = Utils().getYear(dateString: date)
        currentDate = date
        expense = 0.0
        income = 0.0
        sqliteConnection = SqliteConnection()
        sqliteConnection.createDatabase()
        currentDataList = sqliteConnection.getCurrentData(month: month, year: year)
        getIncome()
        getExpense()
        getCurrentBalance()
    }
    
    func getIncome(){
        
        
        let incomeList = currentDataList.filter({$0.isIncome})
        
        incomeList.forEach { (currentData) in
            income += Float(currentData.amount) ?? 0
        }
        incomeData = "$ " + String(income)
        
    }
    
    func getExpense(){
        
        let expenseList = currentDataList.filter({!$0.isIncome})
        
        expenseList.forEach { (currentData) in
            expense += Float(currentData.amount) ?? 0
        }
        expenseData = "$ " + String(expense)
    }
    
    func getCurrentBalance(){
        if((income - expense) < 0 ){
            currentBalanceData = "-$" + String( expense - income)
        }else{
            currentBalanceData = "$" + String( income - expense)
        }
        
    }
    
    func addCurrentData(currentData : CurrentData){
        sqliteConnection.insertCurrentData(currentData: currentData)
        getCurrentData(date: currentData.date)
    }
    
    func editCurrentData(currentData:CurrentData){
        sqliteConnection.editCurrentData(currentData: currentData)
        getCurrentData(date: currentData.date)
    }
    
    func deleteCurrentData(currentData:CurrentData){
        sqliteConnection.deleteCurrentData(currentData: currentData)
        getCurrentData(date: currentData.date)
    }
}
