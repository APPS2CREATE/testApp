//
//  TestCell.swift
//  testApp
//
//  Created by Stefan Adams on 25/02/16.
//  Copyright © 2016 Adams Development. All rights reserved.
//

import UIKit
import CoreData

class TestCell: UITableViewCell {
    
    var check = false
    var tests = Test()
    var test: Test?
    
    @IBOutlet weak var numberTxt: UILabel!
    @IBOutlet weak var textfieldTxt: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(test: Test) {
        numberTxt.text = test.number
        
    }
    
    @IBAction func editBtnPress(sender: AnyObject) {
        guard let textfield = textfieldTxt.text where textfield != "", let number = numberTxt.text where number != "" else {
                return
            }
        
        
        
        numberTxt.text = "\(Int(number)! + Int(textfield)!)"
        check = true
        
    
        CoreDataService.inst.saveData("\(numberTxt.text!)", textfield: "\(textfieldTxt)", test: test)
        
        if check == true {
            
            textfieldTxt.text = ""
            self.endEditing(true)
            check = false
            
        } else {
            // show errorAlert
        }
    }
}
