//
//  User+CoreDataProperties.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 02.05.21.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: String?
    @NSManaged public var peepsInHouse: Int64
    @NSManaged public var propertySize: Int64
    @NSManaged public var houseYear: String?

}

extension User: Identifiable {

}
