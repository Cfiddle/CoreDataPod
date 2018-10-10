//
//  Student.swift
//  CoreDataPod
//
//  Created by Charles Fiedler on 10/9/18.
//  Copyright © 2018 MKD. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataPod {

    @objc(Student)
    public class Student: NSManagedObject {
        
        @NSManaged public var name: String
        @NSManaged public var age: Int16
        @NSManaged public var year: Int16
        @NSManaged public var house: String
        
        public convenience init(name: String, age: Int, year: Int, house: String, using context: NSManagedObjectContext) {
            guard let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)  else { fatalError() }
            self.init(entity: entity, insertInto: context)
            self.name = name
            self.age = Int16(age)
            self.year = Int16(year)
            self.house = house
        }

        @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
            return NSFetchRequest<Student>(entityName: "Student")
        }
    }
}
