//
//  CountrySummary.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI

struct CountrySummary: View {

    let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Footprint overview",
                                                           description: "The CO2 emission level for the Netherlands has been on the decline since 2008.")

    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            TitleAndDescriptionView(viewModel: titleViewModel)
                .padding([.top], 80)

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
                        Text("11.6 tons of CO2")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                        Text("Dutch per capita")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                )

            VStack(alignment: .center, spacing: 0, content: {
                Text("8.2 tons of CO2")
                    .font(.subheadline)
                    .bold()
                Text("EU Average per capita")
                    .font(.subheadline)
            })
            
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CountrySummary_Previews: PreviewProvider {
    static var previews: some View {
        CountrySummary()
    }
}
