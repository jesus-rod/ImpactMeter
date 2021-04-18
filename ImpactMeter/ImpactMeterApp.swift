//
//  ImpactMeterApp.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.02.21.
//

import SwiftUI

@main
struct ImpactMeterApp: App {
    @StateObject var user = User()
    @StateObject var carbonTrackingData = CarbonTrackingData()

    var body: some Scene {
        WindowGroup {
            StartupCoordinator()
                .environmentObject(user)
                .environmentObject(carbonTrackingData)
        }
    }
}
