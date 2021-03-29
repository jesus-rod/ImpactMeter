//
//  TrackIntroSquareTile.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 29.03.21.
//

import SwiftUI

struct TrackIntroSquareTile: View {

    let icon: String

    var body: some View {

        RoundedRectangle(cornerRadius: 10)
            .frame(width: 36, height: 32, alignment: .center)
            .foregroundColor(IMColors.blueishGray)
            .overlay(
                Text(icon)
                    .font(.system(size: 16))
            )
    }
}

struct TrackIntroSquareTile_Previews: PreviewProvider {
    static var previews: some View {
        TrackIntroSquareTile(icon: "🚀")
    }
}
