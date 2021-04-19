//
//  TipView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 18.04.21.
//

import SwiftUI

struct TipView: View {

    struct ViewModel {
        let emoji: Character
        let tip: String
    }

    let viewModel: ViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            Circle()
                .frame(width: 44, height: 44, alignment: .center)
                .foregroundColor(IMColors.anotherGray)
                .overlay(
                    Text(String(viewModel.emoji))
                )

            RichText(viewModel.tip)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.horizontal, 24)
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TipView.ViewModel(emoji: "💡", tip: "Smart plugs are an initial investment but they help reduce *vampire energy consumption up to 87%*")
        TipView(viewModel: viewModel)
    }
}
