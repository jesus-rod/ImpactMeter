//
//  ImpactMeterApp.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.02.21.
//

import SwiftUI

@main
struct ImpactMeterApp: App {
    @StateObject var user = LegacyUser()
    @StateObject var carbonTrackingData = CarbonTrackingData()

    let persistenceController = PersitanceController.shared

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            StartupCoordinator()
                .environmentObject(user)
                .environmentObject(carbonTrackingData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
                persistenceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Scene is in ??")
            }
        }
    }
}
