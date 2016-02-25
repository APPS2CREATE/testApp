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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.delegate = self
       
    }
    
    @IBAction func addArtikel(sender: AnyObject) {
        if let textfield = textfield.text where textfield != "" {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Test", inManagedObjectContext: context)!
            let test = Test(entity: entity, insertIntoManagedObjectContext:  context)
            test.number = textfield
            
            
            context.insertObject(test)
            
            do {
                try context.save()
            } catch {
                print("Kan het artikel niet opslaan!")
            }
            
            dismissViewControllerAnimated(true, completion: nil)
            
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
