//
//  CircleWithText.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.03.21.
//

import SwiftUI

struct CircleWithText: View {

    let viewModel: ViewModel

    var body: some View {
        Circle().foregroundColor(viewModel.color)
            .frame(width: viewModel.diameter, height: viewModel.diameter, alignment: .center)
            .shadow(color: viewModel.color.opacity(0.55),
                    radius: 24, x: 0, y: 12)
            .overlay(
                VStack(alignment: .center, spacing: 10, content: {
                    Text(viewModel.topText)
                        .font(.caption)
                        .foregroundColor(viewModel.textColor)
                    Text(viewModel.bottomText)
                        .font(viewModel.isBigCircle ? .title3 : .subheadline).bold()
                        .foregroundColor(viewModel.textColor)
                })
            )
    }
}

extension CircleWithText {

    struct ViewModel {
        let diameter: CGFloat
        let color: Color
        let textColor: Color
        let topText: String
        let bottomText: String
        let isBigCircle: Bool
    }
}

struct CircleWithText_Previews: PreviewProvider {
    static var previews: some View {
        let textColor = Color.primary.colorInvert() as? Color ?? Color.purple
        let viewModel = CircleWithText
            .ViewModel(diameter: 208, color: .black, textColor: textColor,
                       topText: "Expenses", bottomText: "1,844 kg CO2", isBigCircle: false)
        CircleWithText(viewModel: viewModel)
    }
}
