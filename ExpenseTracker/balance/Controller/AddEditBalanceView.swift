//
//  AddEditBalanceView.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector
import Toast_Swift
class AddEditBalanceView: UIView, CustomSpinnerDelegate {
    

    @IBOutlet weak var spCategory: CustomSpinner!
    @IBOutlet weak var txtCategoryName: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var etAmount: UITextField!
    @IBOutlet weak var txtDate: CustomLabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var btnAddEdit: UIButton!
    
    var parent : MainViewController!
    var categorySelect : Category!
    private var selector : WWCalendarTimeSelector!
    var isEdit = false
    var currentData : CurrentData!
    @IBAction func addBalance(_ sender: Any) {
        if(etAmount.text!.isEmpty){
            makeToast("Please enter amount")
            return
        }
        if(isEdit){
            parent.editBalance(currentData: CurrentData(id: currentData.id, categoryId: categorySelect.id, date: txtDate.text!, amount: etAmount.text!, isIncome: true))
            makeToast("Edit data Success")
        }else{
            parent.addBalance(currentData: CurrentData(id: 0, categoryId: categorySelect.id, date: txtDate.text!, amount: etAmount.text!, isIncome: true))
             makeToast("Add data Success")
        }
        isEdit = false
       
        parent.closeModal()
    }
    @IBAction func cancelBalance(_ sender: Any) {
        parent.closeModal()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.spCategory.updateList(Utils().getCategoryListSpinner())
        self.spCategory.delegate = self
        self.spCategory.changeSelectedIndex(0)
        configureCalendar()
        listeners()
        self.txtDate.text = Utils().currentDay()
        btnAddEdit.setTitle("Add", for: .normal)
        txtTitle.text = "Add Balance"
    }
    
    func editAction(){
        let category = Utils().getCategory(categoryId: currentData.categoryId)
        txtCategoryName.text = category.name
        txtDate.text = currentData.date
        etAmount.text = currentData.amount
        self.spCategory.updateList(Utils().getCategoryListSpinner())
        self.spCategory.delegate = self
        
        self.spCategory.changeSelectedIndex(Utils().getPosition(categoryId: currentData.categoryId))
        btnAddEdit.setTitle("Edit", for: .normal)
        txtTitle.text = "Edit Balance"
    }
    
    func listeners(){
        txtDate.onTap {
            self.showCalendar()
        }
    }
    
    func configureCalendar(){
        selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        let calendar = CustomCalendar()
        calendar.selector = selector
        calendar.configCalendar(showDays: true, showMonth: false, showYear: true)
    }
    
    func showCalendar() {
        
        parent.present(selector, animated: true, completion: nil)
    }
    
    func spinnerChoose(_ spinner: CustomSpinner, index: Int, value: String) {
        categorySelect = Utils().getCategory(categoryId: Utils().getCategoryListIdSpinner()[index])
        txtCategoryName.text = categorySelect.name
        imgCategory.image = categorySelect.image
    }
    
}

extension AddEditBalanceView : WWCalendarTimeSelectorProtocol{
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        self.txtDate.text = formatter.string(from: date)
       /* self.txtCurrentDate.text =  Utils().dateTimeToMonthString(dateString: formatter.string(from: date))
        viewModel.getCurrentData(date: formatter.string(from: date))*/
        
    }
    
    
}
