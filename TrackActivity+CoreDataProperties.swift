//
//  TrackActivity+CoreDataProperties.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 09.05.21.
//
//

import Foundation
import CoreData


extension TrackActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackActivity> {
        return NSFetchRequest<TrackActivity>(entityName: "TrackActivity")
    }

    @NSManaged public var type: String?
    @NSManaged public var amount: Int64
    @NSManaged public var unit: String?
    @NSManaged public var name: String?

}

extension TrackActivity : Identifiable {

}
