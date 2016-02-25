//
//  Test+CoreDataProperties.swift
//  testApp
//
//  Created by Stefan Adams on 25/02/16.
//  Copyright © 2016 Adams Development. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Test {

    @NSManaged var number: String?
    @NSManaged var textfield: String?

}
