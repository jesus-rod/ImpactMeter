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

    var body: some Scene {
        WindowGroup {
            SplashView().environmentObject(user)
        }
    }
}



