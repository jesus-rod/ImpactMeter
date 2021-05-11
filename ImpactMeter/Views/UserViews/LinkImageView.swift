//
//  LinkImageView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 10.05.21.
//

import SwiftUI

struct LinkImageView: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("Change personal details")
                .font(.callout)
                .fontWeight(Font.Weight.semibold)
                .foregroundColor(IMColors.darkGray)
            Image(systemName: "arrow.forward.circle.fill")
                .foregroundColor(IMColors.darkGray)
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }
}

struct LinkImageView_Previews: PreviewProvider {
    static var previews: some View {
        LinkImageView()
    }
}
