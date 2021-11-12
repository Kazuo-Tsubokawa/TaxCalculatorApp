//
//  ViewController.swift
//  TaxCalculatorApp
//
//  Created by 坪川和生 on 2021/11/09.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var taxController: UISegmentedControl! //読み取り
    @IBOutlet weak var itemTableView: UITableView!
    //変数を追加
    var cost:Double = 0
    var addTaxCost:Double = 0
    var costsArray:[Double] = []
    var addTaxCostString:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        costsArray.removeAll()
        costField.addTarget(self, action: #selector(costFieldDidChange), for: .editingChanged)
        costField.keyboardType = UIKeyboardType.numberPad
    }
    
    @objc func costFieldDidChange(sender: UITextField) {  //値の取得
        
        if costField.text != "" &&  Int(costField.text!) != nil {
            if taxController.selectedSegmentIndex == 0 {
                calc(tax:1.1)
            } else {
                calc(tax: 1.08)
            }
        } else {
            costField.text = ""
            showLabel.text = ""
        }
    }
    
    @IBAction func taxChanger(_ sender: Any) {
        
        if costField.text != "" &&  Int(costField.text!) != nil {
            if taxController.selectedSegmentIndex == 0 {
                calc(tax:1.1)
            } else {
                calc(tax: 1.08)
            }
        } else {
            costField.text = ""
            showLabel.text = ""
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        if addTaxCost != 0 {
            print(addTaxCost)
            costsArray.append(contentsOf: [addTaxCost])
            
            UserDefaults.standard.set(costsArray, forKey: "item")
            
            addTaxCost = 0
            costField.text = ""
            showLabel.text = ""
            
            self.itemTableView.reloadData()
        }
    }
    
    func calc(tax:Double) {
        cost = Double(costField.text!)!
        addTaxCost = cost * Double(tax)
        
        addTaxCostString = String(format: "%.0f", addTaxCost)
        showLabel.text = addTaxCostString
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(costsArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            costsArray.remove(at: indexPath.row)
            
            UserDefaults.standard.set(costsArray, forKey: "item")
            
            itemTableView.reloadData()
        }
    }
    
    
    
}

