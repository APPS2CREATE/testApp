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
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var textfield: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(test: Test) {
        number.text = test.number
        
    }
    
    @IBAction func editBtnPress(sender: AnyObject) {
        if let textfield = textfield.text where textfield != "" {
            
            number.text = "\(Int(number.text!)! - Int(textfield)!)"
            check = true
        }
        
        if check == true {
            
            textfield.text = ""
            self.endEditing(true)
            check = false
            
        } else {
            // show errorAlert
        }
    }
}
