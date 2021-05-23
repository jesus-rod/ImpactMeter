//
//  CircleOverCircleView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.05.21.
//

import SwiftUI

struct CircleOverCircleView: View {

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

        TitleAndDescriptionView(viewModel: titleViewModel)
        Circle()
            .foregroundColor(.blue)
            .frame(width: 192, height: 192, alignment: .center)
            .shadow(color: Color.blue.opacity(0.56), radius: 24, x: 0, y: 12)
            .background(
                Circle()
                    .foregroundColor(IMColors.blueishGray)
                    .frame(width: 160, height: 160, alignment: .center)
                    .offset(x: 0, y: 64))
            .overlay(
                VStack {
                    Text(viewModel.circleTitle)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    Text(viewModel.circleSubtitle)
                        .font(.subheadline)
                        .foregroundColor(.white)
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

struct CircleOverCircleView_Previews: PreviewProvider {
    static var previews: some View {

        let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Footprint overview",
                                                               description: "The CO2 emission level for the Netherlands has been on the decline since 2008.")

        let circleOverCircleVm = CircleOverCircleView.ViewModel(circleTitle: "11.6 tons of CO2", circleSubtitle: "Dutch per capita", circleColor: Color.blue, circleUndertextTitle: "8.2 tons of CO2", circleUndertextSubTitle: "EU Average per capita")
        CircleOverCircleView(titleViewModel: titleViewModel, viewModel: circleOverCircleVm)
    }
}
