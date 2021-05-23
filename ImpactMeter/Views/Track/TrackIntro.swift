//
//  TrackIntro.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 29.03.21.
//

import SwiftUI
import NavigationStack

struct TrackIntro: View {

    @State private var beginTracking = false
    let navigationStack: NavigationStack = NavigationStack()

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track your first activity", description: "Your footprint is currently not displaying anything because you haven’t tracked any activity yet.")

        VStack(alignment: .leading, spacing: 88) {
            TitleAndDescriptionView(viewModel: titleVm)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            TrackIntroTiles()
            VStack {
                Button {
                    beginTracking.toggle()
                } label: {
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
                    .padding([.horizontal], 24)
                    .padding([.bottom], 20)
                }

            }
            .ignoresSafeArea(edges: .all)

        }.fullScreenCover(isPresented: $beginTracking) {
            NavigationStackView(navigationStack: navigationStack) {
                AppScreen {
                    TrackNewActivityScreen()
                }
            }
        }.onAppear {
            let user = PersistanceController.shared.fetchUser()
            print("--------")
            print(user)
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
