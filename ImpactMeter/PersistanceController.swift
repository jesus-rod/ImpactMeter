//
//  PersistanceController.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//

import CoreData
import SwiftUI

struct PersistanceController {

    static let shared = PersistanceController()
    private let userId = "userId"

    let container: NSPersistentContainer
    let log = LoggingController.shared.log

    func fetchUser() -> User {
        let context = container.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.fetchBatchSize = 2
        fetchRequest.predicate = NSPredicate(format: "id = %@", userId)

        do {
            let users = try context.fetch(fetchRequest)
            assert(users.count < 2) // we shouldn't have any duplicates in CD

            if let user = users.first as? User {
                // we've got the profile already cached!
                return user
            } else {
                // no local cache yet, use placeholder for now
                let user = createUser()
                return user
            }
        } catch {
            print("Error loading user from Persistance")
            print(error.localizedDescription)
        }
        return createUser()
    }

    // don't make this public ever
    private func createUser() -> User {
        // First time launching app
        let user = User(context: container.viewContext)
        user.id = userId
        save()
        return user
    }

    init() {
        // The name below must match the name of the xcdatamodeld file 🤦🏻‍♂️
        container = NSPersistentContainer(name: "ImpactMeter")
        container.loadPersistentStores { [self] (persistentStoreDescription, error) in
            if let error = error {
                fatalError("failed to load persistence \(error.localizedDescription)")
            }
            self.log.info("Your database is at \(String(describing: persistentStoreDescription.url))")
        }

        // Add a debugging flag to clear core data
        // wipeAllUsers()
    }

    func save(completion: @escaping (Error?) -> Void = { _ in}) {
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
        save(completion: completion)
    }

    // Careful - Only call this if you are sure what you are doing
    private func wipeAllUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = container.viewContext

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            log.error("error deleting everything \(error.localizedDescription)")
        }
    }

    @discardableResult func addTrackedActivity(amount: Int, trackActivity: Trackable) -> TrackActivity {
        let activity = TrackActivity(context: container.viewContext)
        activity.amount = Int64(amount)
        activity.name = trackActivity.storageKey
        activity.unit = trackActivity.unit
        activity.type = trackActivity.type.rawValue
        save()
        return activity
    }
}
