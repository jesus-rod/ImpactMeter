//
//  TrackIntro.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 29.03.21.
//

import SwiftUI

struct TrackIntro: View {
    @StateObject var carbonTrackingData = CarbonTrackingData()

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track your first activity", description: "Your footprint is currently not displaying anything because you haven’t tracked any activity yet.")
        NavigationView {
            VStack(alignment: .leading, spacing: 88) {
                TitleAndDescriptionView(viewModel: titleVm)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TrackIntroTiles()

                VStack {
                    NavigationLink(destination: PeopleInHouseScreen().environmentObject(carbonTrackingData)) {
                        HStack(spacing: 14) {
                            Text("Track Now")
                                .foregroundColor(.blue)
                                .font(Font.system(size: 20, weight: .bold))

                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(Font.system(size: 15).bold())
                                .background(
                                    Circle().foregroundColor(.blue)
                                        .frame(width: 24, height: 24, alignment: .center)
                                )
                        }
                    }.padding([.leading, .trailing], 24)
                        .padding([.bottom], 20)
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(edges: .all)
            .navigationBarTitle("")
        }
    }
}

struct TrackIntro_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrackIntro()
        }
    }
}
