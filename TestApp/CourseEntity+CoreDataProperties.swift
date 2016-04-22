//
//  CourseEntity+CoreDataProperties.swift
//  TestApp
//
//  Created by Gatsby on 16/4/20.
//  Copyright © 2016年 pzyyll. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CourseEntity {

    @NSManaged var c_No: String?
    @NSManaged var c_Name: String?
    @NSManaged var c_Introduction: String?
    @NSManaged var c_AppdendTime: String?
    @NSManaged var l_No: String?

}
