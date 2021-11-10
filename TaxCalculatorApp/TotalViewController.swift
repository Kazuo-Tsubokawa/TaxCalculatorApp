//
//  TotalViewController.swift
//  TaxCalculatorApp
//
//  Created by 坪川和生 on 2021/11/10.
//

import UIKit

class TotalViewController: UIViewController {
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    var resultArray: [Double] = []
    var sum: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultArray = UserDefaults.standard.object(forKey: "item") as! [Double]
        print(resultArray)
        sum = resultArray.reduce(0) { (num1:Double, num2:Double) -> Double in
            return num1 + num2
        }
        TotalLabel.text = String(format: "%.0f", sum)
    }
    
    
}
