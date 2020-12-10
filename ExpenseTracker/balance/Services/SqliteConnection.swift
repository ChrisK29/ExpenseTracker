//
//  SqliteConnection.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import SQLite

class SqliteConnection {
    
    var database : Connection!
    let balanceDataTable = Table("balanceData")
    let id = Expression<Int>("id")
    let idCategory = Expression<Int>("idCategory")
    let date = Expression<String>("date")
    let amount = Expression<Double>("amount")
    let month = Expression<String>("month")
    let year = Expression<String>("year")
    
    
    func createDatabase(){
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("database").appendingPathExtension("sqlite3")
            database = try Connection(fileUrl.path)
            createBalanceTable()
        }catch{
            print(error)
        }
    }
    
    
    func createBalanceTable(){
        let createTable = self.balanceDataTable.create{ (table) in
            table.column(self.id,primaryKey: true)
            table.column(self.idCategory)
            table.column(self.amount)
            table.column(self.date)
            table.column(self.month)
            table.column(self.year)
        }        
        do{
            try self.database.run(createTable)
            print("Table Created success")
        } catch{
            print(error)
        }
    }
    
    
    func insertCurrentData(currentData : CurrentData){
        print("insertData")
        let month = Utils().getMonth(dateString: currentData.date)
        let year = Utils().getYear(dateString: currentData.date)
        let insertData = self.balanceDataTable.insert(self.idCategory <- Int(currentData.categoryId)!, self.amount <- Double(currentData.amount)!,self.date <- currentData.date, self.month <- month, self.year <- year)
        do{
            try self.database.run(insertData)
            print("Current data Inserted Success")
        }catch{
            print(error)
        }
        
    }
    
    
    func getCurrentData(month:String, year:String) -> [CurrentData]{
        var currentDataList = [CurrentData]()
        do{
            
            let currentDataQuery = self.balanceDataTable.filter(self.month == month).filter(self.year == year)
                .order(self.date.asc)
            
            let currentDataStatement = try self.database.prepare(currentDataQuery)
         
            for data in currentDataStatement{
                let category = Utils().getCategory(categoryId: String(data[self.idCategory] ))
                
                let currentData = CurrentData(id: Int(data[self.id] ) ,categoryId: String(data[self.idCategory]), date: data[self.date] , amount: String(data[self.amount] ), isIncome: category.isIncome)
                currentDataList.append(currentData)
            }
            
        }catch{
            print(error)
        }
        return currentDataList
    }
    
    
    func editCurrentData(currentData : CurrentData){
        print("Update data")
        print(currentData.id)
        let month = Utils().getMonth(dateString: currentData.date)
        let year = Utils().getYear(dateString: currentData.date)
        let currentDataQuery = self.balanceDataTable.filter(self.id == currentData.id)
        let updateCurrentData = currentDataQuery.update(self.idCategory <- Int(currentData.categoryId)!, self.amount <- Double(currentData.amount)!,self.date <- currentData.date, self.month <- month, self.year <- year)
        do{
            try self.database.run(updateCurrentData)
            print("Update success")
        }catch{
            print(error)
        }
    }
    
    func deleteCurrentData(currentData : CurrentData){
        print("Delete data")
        let currentDataQuery = self.balanceDataTable.filter(self.id == currentData.id)
        let deleteCurrentData = currentDataQuery.delete()
        do{
            try self.database.run(deleteCurrentData)
            print("Deleted row success")
        }catch{
            print(error)
        }
    }
}
