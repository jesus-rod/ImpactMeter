//
//  TrackIntroTiles.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import SwiftUI

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

struct TrackIntroTiles_Previews: PreviewProvider {
    static var previews: some View {
        TrackIntroTiles()
    }
}
