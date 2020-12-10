//
//  CurrentDataCVDataSourceDelegate.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
class CurrentDataCVDataSourceDelegate : NSObject{
    var dataList : [CurrentData]
    var parent : MainViewController
    init(dataList : [CurrentData],parent : MainViewController){
        self.dataList = dataList
        self.parent = parent
    }
}

extension CurrentDataCVDataSourceDelegate : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! CurrentDataCollectionViewCell
        
        let category = Utils().getCategory(categoryId: dataList[indexPath.row].categoryId)
        
        cell.txtCategory.text = category.name
        if (dataList[indexPath.row].isIncome){
            cell.txtAmount.text = "+ $" + dataList[indexPath.row].amount
            cell.txtAmount.textColor = .green
        }else{
            cell.txtAmount.text = "- $" + dataList[indexPath.row].amount
            cell.txtAmount.textColor = .red
        }
        cell.imgCategory.image = category.image
        cell.txtDate.text = Utils().dateTimeToString(dateString: dataList[indexPath.row].date)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            
            
        let action = UIAction(title: "Edit", image: UIImage(named: "edit")) { (action) in
            self.parent.editCurrentData(currentData: self.dataList[indexPath.row])
        }
        
        let action2 = UIAction(title: "Delete", image: UIImage(named: "delete")) { [self] (action) in
            self.parent.deleteBalance(currentData: self.dataList[indexPath.row])
        }
        
        return UIMenu(title: "", children: [action,action2])
        }
        return configuration
    }
    
    
}
