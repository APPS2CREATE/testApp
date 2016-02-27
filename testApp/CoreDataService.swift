//
//  CoreDataService.swift
//  testApp
//
//  Created by Stefan Adams on 27/02/16.
//  Copyright © 2016 Adams Development. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    static let inst = CoreDataService()
    
    private var _tests = [Test]()
    
    private let APP: AppDelegate
    private let MOC: NSManagedObjectContext
    private let FETCH: NSFetchRequest
    
    var tests: [Test] {
        return _tests
    }
    
    init() {
        APP = UIApplication.sharedApplication().delegate as! AppDelegate
        MOC = APP.managedObjectContext
        FETCH = NSFetchRequest(entityName: "Test")
    }
    
    func fetchData() {
        do {
            let result = try MOC.executeFetchRequest(FETCH)
            guard let resultList = result as? [Test] else {
                print("Corrupted Data in CoreData")
                return
            }
            _tests = resultList
        } catch {
            print("Nothing loaded from CoreData")
        }
    }
    
    func deleteData(index: Int) {
        let item = _tests[index]
        
        MOC.deleteObject(item)
        
        guard saveMOC() else {
            return
        }
        
        fetchData()
        
        reloadNotif()
    }
    
    func saveData(number: String, textfield: String, test: Test?) -> Bool {
        guard let entity = NSEntityDescription.entityForName("Test", inManagedObjectContext: MOC) else {
            print("Could not create enitity")
            return false
        }
        
        let tester = test == nil
        
        let tests = tester ? Test(entity: entity, insertIntoManagedObjectContext: MOC) : test!
        
        tests.textfield = textfield
        tests.number = number
        
        if tester {
            MOC.insertObject(tests)
        }
        
        guard saveMOC() else {
            return false
        }
        
        fetchData()
        
        reloadNotif()
        
        return true
    }
    
    private func reloadNotif() {
        NSNotificationCenter.defaultCenter().postNotificationName("reloadData", object: nil)
    }
    
    private func saveMOC() -> Bool {
        do {
            try MOC.save()
            return true
        } catch {
            print("Couldn't save to CoreData")
            return false
        }
    }
}
