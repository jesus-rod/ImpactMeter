//
//  PersistanceController.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//

import CoreData

struct PersitanceController {

    static let shared = PersitanceController()

    let container: NSPersistentContainer

    init() {
        // The name below must match the name of the xcdatamodeld file 🤦🏻‍♂️
        container = NSPersistentContainer(name: "ImpactMeter")
        // swiftlint:disable:next unused_closure_parameter
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("failed to load persistence \(error.localizedDescription)")
            }
        }
    }

    func save(completion: @escaping (Error?) -> Void  = { _ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> Void  = { _ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion )
    }
}
