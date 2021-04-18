//
//  CircleInCircleView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 18.04.21.
//

import SwiftUI

struct CircleInCircleView: View {

    let titleViewModel: TitleAndDescriptionView.ViewModel

    let viewModel: ViewModel

    struct ViewModel {
        let circleTitle: String
        let circleSubtitle: String
        let circleColor: Color
        let circleUndertextTitle: String
        let circleUndertextSubTitle: String
    }

    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            TitleAndDescriptionView(viewModel: titleViewModel)

            Circle()
                .foregroundColor(viewModel.circleColor)
                .frame(width: 180, height: 180, alignment: .center)
                .shadow(color: Color.black.opacity(0.5), radius: 24, x: 0, y: 12)
                .background(
                    Circle()
                        .foregroundColor(IMColors.blueishGray)
                        .frame(width: 240, height: 240, alignment: .center)
                        .offset(x: 0, y: 25))
                .overlay(
                    VStack(alignment: .center) {
                        Text(viewModel.circleTitle)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                        Text(viewModel.circleSubtitle)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                    }
                )

            VStack(alignment: .center, spacing: 0, content: {
                Text(viewModel.circleUndertextTitle)
                    .font(.subheadline)
                    .bold()
                Text(viewModel.circleUndertextSubTitle)
                    .font(.subheadline)
            })

        }
    }
}

struct CircleInCircleView_Previews: PreviewProvider {
    static var previews: some View {

        let titleViewModel2 = TitleAndDescriptionView.ViewModel(title: "Your emissions",
                                                                description: "Calculating your personal footprint is done automatically and it will be compared to average levels in your area.")

        let circleViewModel = CircleInCircleView.ViewModel(circleTitle: "Footprint", circleSubtitle: "test sub", circleColor: Color.primary, circleUndertextTitle: "8.2 tons of CO2", circleUndertextSubTitle: "EU Average per capita")
        CircleInCircleView(titleViewModel: titleViewModel2, viewModel: circleViewModel)
    }
}
