//
//  MainTabView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.03.21.
//

import SwiftUI

struct MainTabView: View {

    @State var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            //Screen one
            TrackIntro().tabItem {
                selectedTab == 1 ? Image("PlusActive") : Image("Plus")
            }.tag(1)
            //Screen Two
            VStack {
                DashboardSummaryView()
            }.tabItem {
                selectedTab == 2 ? Image("MeterActive") : Image("Meter")
            }.tag(2)
            //Screen Three
            VStack {
                Text("Screen 3")
            }.tabItem {
                selectedTab == 3 ? Image("LeafActive") : Image("Leaf")
            }.tag(3)
        }.accentColor(.primary)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
