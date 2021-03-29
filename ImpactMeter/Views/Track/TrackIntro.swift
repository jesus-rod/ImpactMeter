//
//  TrackIntro.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 29.03.21.
//

import SwiftUI

struct TrackIntro: View {
    var body: some View {

        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track your first activity", description: "Your footprint is currently not displaying anything because you haven’t tracked any activity yet.")
        VStack(alignment: .leading, spacing: 88) {
            TitleAndDescriptionView(viewModel: titleVm)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            TrackIntroTiles()

            VStack() {
                Button(action: {
                    print("Do a tracking")
                }, label: {
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
                }).padding([.leading, .trailing], 24)
                .padding([.bottom], 52
                )
            }
        }


    }
}

struct TrackIntroTiles: View {

    private let trackOne = ["🚗", "✈️", "🍕", "🥗", "♻️", "🥝", "🛒"]
    private let trackTwo = ["🍳", "💡", "🛒", "🍌", "⚡️", "⛴"]
    private let trackThree = ["♻️", "🔥", "🍱", "☕️", "💧", "🎄", "✈️"]
    private let trackFour = ["🥑", "🍗", "📺", "🖥", "💧", "⚡️", "🛒"]
    private let trackFive = ["🛋", "☕️", "🛒", "💡", "🥝", "🚗", "🍕️"]

    var body: some View {
        VStack(alignment: .center, spacing: 24) {

            // Track One
            HStack(spacing: 16) {
                ForEach(trackOne, id: \.self) { (item) in
                    TrackIntroSquareTile(icon: item)
                }
            }.offset(x: 45, y: 0)

            // Track Two

            HStack(spacing: 16) {
                ForEach(trackTwo, id: \.self) { (item) in
                    TrackIntroSquareTile(icon: item)
                }
            }.offset(x: -5, y: 0)

            // Track Three
            HStack(spacing: 16) {
                ForEach(trackThree, id: \.self) { (item) in
                    TrackIntroSquareTile(icon: item)
                }
            }.offset(x: -15, y: 0)

            // Track Four
            HStack(spacing: 16) {
                ForEach(trackFour, id: \.self) { (item) in
                    TrackIntroSquareTile(icon: item)
                }
            }.offset(x: 45, y: 0)

            // Track Five
            HStack(spacing: 16) {
                ForEach(trackFive, id: \.self) { (item) in
                    TrackIntroSquareTile(icon: item)
                }
            }.offset(x: 10, y: 0)
        }
    }

}

struct TrackIntro_Previews: PreviewProvider {
    static var previews: some View {
        TrackIntro()
    }
}
