//
//  TrackIntroTiles.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import SwiftUI

struct TrackIntroTiles: View {

    private let trackOne: [String] = ["🚗", "✈️", "🍕", "🥗", "♻️", "🥝", "🛒"]
    private let trackTwo = ["🍳", "💡", "🛒", "🍌", "⚡️", "⛴"]
    private let trackThree = ["♻️", "🔥", "🍱", "☕️", "💧", "🎄", "✈️"]
    private let trackFour = ["🥑", "🍗", "📺", "🖥", "💧", "⚡️", "🛒"]
    private let trackFive = ["🛋", "☕️", "🛒", "💡", "🥝", "🚗", "🍕️"]

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            IntroTrackLane(track: trackOne, initialOffset: 45, animationDelay: 0.1, direction: IntroTrackLane.Direction.left)
            IntroTrackLane(track: trackTwo, initialOffset: -5, animationDelay: 0.2)
            IntroTrackLane(track: trackThree, initialOffset: -15, animationDelay: 0.4)
            IntroTrackLane(track: trackFour, initialOffset: 45, animationDelay: 0.2, direction: IntroTrackLane.Direction.left)
            IntroTrackLane(track: trackFive, initialOffset: 10, animationDelay: 0.4)
        }
    }
}

struct IntroTrackLane: View {
    enum Direction {
        case left
        case right
    }
    @State private var extraHorizontalOffset: CGFloat = 0.0
    private let animationDuration: Double = Double.random(in: 6...8)
    let track: [String]
    let initialOffset: CGFloat
    let animationDelay: Double
    let direction: Direction

    init(track: [String], initialOffset: CGFloat, animationDelay: Double = 0, direction: Direction = Direction.right) {
        self.track = track
        self.initialOffset = initialOffset
        self.animationDelay = animationDelay
        self.direction = direction
    }

    private var foreverAnimation: Animation {
        Animation.easeIn(duration: animationDuration)
            .repeatForever().delay(animationDelay)
    }

    var body: some View {
        GeometryReader { _ in
            HStack(spacing: 16) {
                ForEach(track, id: \.self) { item in
                    TrackIntroSquareTile(icon: item)
                }
            }
            .offset(x: initialOffset +  extraHorizontalOffset, y: 0)
            .onAppear {
                withAnimation(self.foreverAnimation) {
                    if direction == .left {
                        extraHorizontalOffset = -50
                        return
                    }
                    extraHorizontalOffset = 50
                }
            }

        }
    }
}

struct TrackIntroTiles_Previews: PreviewProvider {
    static var previews: some View {
        TrackIntroTiles()
    }
}
