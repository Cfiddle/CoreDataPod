//
//  Address.swift
//  CoreDataPod
//
//  Created by Charles Fiedler on 10/9/18.
//  Copyright © 2018 MKD. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataPod {

    @objc(Address)
    public class Address: NSManagedObject {
        
        @NSManaged public var city: String
        @NSManaged public var country: String
        @NSManaged public var street: String

        public convenience init(city: String, country: String, street: String, using context: NSManagedObjectContext) {
            guard let entity = NSEntityDescription.entity(forEntityName: "Address", in: context)  else { fatalError() }
            self.init(entity: entity, insertInto: context)
            self.city = city
            self.country = country
            self.street = street
        }
        
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
            return NSFetchRequest<Address>(entityName: "Address")
        }
    }
}
