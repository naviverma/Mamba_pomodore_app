//
//  Task+CoreDataProperties.swift
//  MAMBA
//
//  Created by Navdeep on 01/08/2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var task: NSObject?
    @NSManaged public var category: NSObject?
    @NSManaged public var importance: NSObject?
    @NSManaged public var deadline: NSObject?

}

extension Task : Identifiable {

}
