//
//  User+CoreDataProperties.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var peepsInHouse: Int16
    @NSManaged public var propertySize: String?
    @NSManaged public var country: Int16
    @NSManaged public var id: UUID?

}

extension User: Identifiable {

}
