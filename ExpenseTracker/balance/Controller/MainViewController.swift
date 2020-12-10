//
//  ViewController.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector

class MainViewController: UIViewController {
    @IBOutlet weak var txtCurrentBalance: UILabel!
    @IBOutlet weak var txtCurrentDate: CustomLabel!
    @IBOutlet weak var txtIncome: UILabel!
    @IBOutlet weak var txtExpense: UILabel!
    @IBOutlet weak var cvCurrentData: UICollectionView!
    @IBOutlet weak var btnAddData: CustomImageView!
    
    private var selector : WWCalendarTimeSelector!
    private var currentDataCVDataSourceDelegate : CurrentDataCVDataSourceDelegate!
    private var viewModel = MainViewModel()
    
    var addEditBalanceView : AddEditBalanceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        configureCalendar()
        observers()
        listeners()
    }
    
    func listeners(){
        btnAddData.onTap {
            self.showModal()
        }
        
        txtCurrentDate.onTap {
            self.showCalendar()
        }
    }
    
    func initData(){
        txtCurrentDate.text = Utils().currentMonth(date: Date())
    }
    
    func observers(){
        
        
        viewModel.currentDataListSuccess = {
            self.txtCurrentDate.text = Utils().dateTimeToMonthString(dateString: self.viewModel.currentDate)
            self.initCollectionView(dataList: self.viewModel.currentDataList)
        }
        
        viewModel.currentBalanceSuccess = {
            self.txtCurrentBalance.text = self.viewModel.currentBalanceData
        }
        
        viewModel.incomeDataSuccess = {
            self.txtIncome.text = self.viewModel.incomeData
        }
        
        viewModel.expenseDataSuccess = {
            self.txtExpense.text = self.viewModel.expenseData
        }
        
        viewModel.getCurrentData(date: Utils().currentDay())
    }
    
    func showModal(){
        addEditBalanceView = (Bundle.main.loadNibNamed("AddEditBalanceView", owner: self, options: nil)?.first as! AddEditBalanceView)
        addEditBalanceView.parent = self
        addEditBalanceView.frame = self.view.frame
        self.view.addSubview(self.addEditBalanceView)
    }
    
    func closeModal(){
        self.addEditBalanceView.removeFromSuperview()
        addEditBalanceView = nil
    }
    
    func addBalance(currentData: CurrentData){
        viewModel.addCurrentData(currentData: currentData)
    }

    func editBalance(currentData : CurrentData){
        viewModel.editCurrentData(currentData: currentData)
    }
    
    func deleteBalance(currentData: CurrentData){
        viewModel.deleteCurrentData(currentData: currentData)
    }
    
    func initCollectionView(dataList : [CurrentData]){
        currentDataCVDataSourceDelegate = CurrentDataCVDataSourceDelegate(dataList:dataList,parent: self)
        cvCurrentData.dataSource = currentDataCVDataSourceDelegate
        cvCurrentData.delegate = currentDataCVDataSourceDelegate
        cvCurrentData.reloadData()
        
    }
    
    func configureCalendar(){
        selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        let calendar = CustomCalendar()
        calendar.selector = selector
        calendar.configCalendar(showDays: false, showMonth: true, showYear: true)
    }
    
    func showCalendar() {
     present(selector, animated: true, completion: nil)
    }
    
    func editCurrentData(currentData:CurrentData){
        addEditBalanceView = (Bundle.main.loadNibNamed("AddEditBalanceView", owner: self, options: nil)?.first as! AddEditBalanceView)
        addEditBalanceView.parent = self
        addEditBalanceView.isEdit = true
        addEditBalanceView.currentData = currentData
        addEditBalanceView.editAction()
        addEditBalanceView.frame = self.view.frame
        self.view.addSubview(self.addEditBalanceView)
    }

}

extension MainViewController : WWCalendarTimeSelectorProtocol{
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        self.txtCurrentDate.text =  Utils().dateTimeToMonthString(dateString: formatter.string(from: date))
        viewModel.getCurrentData(date: formatter.string(from: date))
        
    }
    
    
}
