//
//  School.swift
//  CoreDataPod
//
//  Created by Charles Fiedler on 10/9/18.
//  Copyright © 2018 MKD. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataPod {

    @objc(School)
    public class School: NSManagedObject {
        
        @NSManaged public var name: String
        @NSManaged public var age: Int16
        @NSManaged public var numOfRooms: Int16
        @NSManaged public var houses: Set<String>
        @NSManaged public var location: Address
        @NSManaged public var students: Set<Student>

        public convenience init(name: String, age: Int, numOfRooms: Int, houses: Set<String>, location: Address, students: Set<Student>, using context: NSManagedObjectContext) {
            guard let entity = NSEntityDescription.entity(forEntityName: "School", in: context)  else { fatalError() }
            self.init(entity: entity, insertInto: context)
            self.name = name
            self.age = Int16(age)
            self.numOfRooms = Int16(numOfRooms)
            self.houses = houses
            self.location = location
            self.students = students
        }

        @nonobjc public class func fetchRequest() -> NSFetchRequest<School> {
            return NSFetchRequest<School>(entityName: "School")
        }
    }
}
