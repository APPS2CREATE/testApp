//
//  addVC.swift
//  testApp
//
//  Created by Stefan Adams on 25/02/16.
//  Copyright © 2016 Adams Development. All rights reserved.
//

import UIKit
import CoreData

class addVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textfield: UITextField!
    
    var test: Test?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.delegate = self
       
    }
    
    @IBAction func addArtikel(sender: AnyObject) {
        guard let textfield = textfield.text where textfield != "" else {
            return
        }
        
        
        CoreDataService.inst.saveData("\(textfield)", textfield: "\(textfield)", test: test)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
