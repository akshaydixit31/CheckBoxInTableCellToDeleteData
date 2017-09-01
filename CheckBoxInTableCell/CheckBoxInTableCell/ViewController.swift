//
//  ViewController.swift
//  CheckBoxInTableCell
//
//  Created by Appinventiv Technologies on 01/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//---------- Outlet's ---------------
    @IBOutlet weak var tableView: UITableView!
    //---------- Variable's -------------
    var itemList = ["Apple","Lava","MI","Samsung","Sony","Vivo","Window","Apple","Lava","MI","Samsung","Sony","Vivo","Window","Apple","Lava","MI","Samsung","Sony","Vivo","Window"]
    var buttonName = [String]()
//---------- ViewDidLoad method ----------
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        for tempIndex in 0..<itemList.count{
            buttonName.insert("Uncheck", at: tempIndex)
        }
        
    }
//    ================= Button Action's ================
    
//    ---------------- ButtonOnCell Action -------------
    @IBAction func buttonOnCell(_ sender: UIButton) {
        guard   let cell = getCell(sender) as? CellData else{fatalError()}
        guard let indexPath = self.tableView.indexPath(for: cell) else {fatalError()}
    
        if cell.checkBoxImage.image == UIImage(named: "Uncheck"){
            cell.checkBoxImage.image = UIImage(named: "checked")
            buttonName[indexPath.row] = "checked"
        }
        else if cell.checkBoxImage.image == UIImage(named: "checked"){
            cell.checkBoxImage.image = UIImage(named: "Uncheck")
            buttonName[indexPath.row] = "Uncheck"
        }
        tableView.reloadData()
    }
//    ---------------- DeleteButton ---------------
    @IBAction func deleteButton(_ sender: UIButton) {
        var tempArray = [String]()
        for tempIndex in 0..<itemList.count{
            if buttonName[tempIndex] == "Uncheck"{
                tempArray.append(itemList[tempIndex])
            }
        }
        
        buttonName.removeAll()
        itemList.removeAll()
        itemList = tempArray
        for tempIndex in 0..<itemList.count{
            buttonName.insert("Uncheck", at: tempIndex)
        }
        tableView.reloadData()
    }

}
//=============== ViewDidLoad extension =============
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
//---------------------- Method for tableView ----------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellData", for: indexPath) as? CellData else{fatalError()}
        cell.buttonOnCell.setTitle(itemList[indexPath.row], for: .normal)
        cell.checkBoxImage.image = UIImage(named: buttonName[indexPath.row])
        return cell
    }
//------------------------- Method's of class----------------------------
    func getCell(_ button: UIButton) -> UITableViewCell{
        var cell : UIView = button
        while !(cell is CellData) {
            if let super_view = cell.superview {
                cell = super_view
            }else{}
        }
        guard let tableCell = cell as? CellData else {fatalError()}
        return tableCell
    }

}
//=============== Class for cell data =============

class CellData: UITableViewCell {
//-------- Outlet's -----------
    @IBOutlet weak var buttonOnCell: UIButton!
    @IBOutlet weak var checkBoxImage: UIImageView!
}


























