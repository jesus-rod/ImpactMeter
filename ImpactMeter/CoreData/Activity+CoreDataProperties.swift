//
//  Activity+CoreDataProperties.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//
//

import Foundation
import CoreData

extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var name: String?
    @NSManaged public var kgEmission: Int16

}

extension Activity : Identifiable {

}
