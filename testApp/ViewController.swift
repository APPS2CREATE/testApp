//
//  ViewController.swift
//  testApp
//
//  Created by Stefan Adams on 25/02/16.
//  Copyright © 2016 Adams Development. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataService.inst.fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableView", name: "reloadData", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("TestCell") as? TestCell else {
            return TestCell()
        }
        
        let test = CoreDataService.inst.tests[indexPath.row]
        cell.configureCell(test)
        
        return cell    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        
        let editAction = UITableViewRowAction(style: .Default, title: "Edit") { (UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            let row = CoreDataService.inst.tests[indexPath.row]
            self.performSegueWithIdentifier("AddVC", sender: row)
        }

        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            CoreDataService.inst.deleteData(indexPath.row)
        }
        
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction, editAction]
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CoreDataService.inst.tests.count
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.tableView.endEditing(true)
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

