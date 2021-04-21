//
//  UtilityTrackingSummaryScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack

struct UtilityTrackingSummaryScreen: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        let titleViewModel2 = TitleAndDescriptionView.ViewModel(title: "Calculated emissions",
                                                                description: "Calculating your personal footprint is done automatically and it will be compared to average levels in your area.")
        let circleViewModel = CircleInCircleView.ViewModel(circleTitle: "220 kWh", circleSubtitle: "your energy consumption", circleColor: Color.orange, circleUndertextTitle: "Average consumption", circleUndertextSubTitle: "in your area")

        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CircleInCircleView(titleViewModel: titleViewModel2, viewModel: circleViewModel)

                let tipOneViewModel = TipView.ViewModel(emoji: "💡", tip: "Smart plugs are an initial investment but they help reduce *vampire energy consumption up to 87%*")

                let tipTwoViewModel = TipView.ViewModel(emoji: "💤", tip: "A lot of modern devices *have super-low energy standby mode settings.* Try switching to this mode when possible.")

                    VStack(alignment: .leading, spacing: 24) {

                        Text("Worth considering")
                            .font(.title3)
                            .bold()
                            .padding([.bottom, .horizontal], 24)

                        TipView(viewModel: tipOneViewModel)
                        TipView(viewModel: tipTwoViewModel)

                        PopView(destination: .root) {
                            PrimaryButton(title: "Okay") {
                                presentationMode.wrappedValue.dismiss()
                            }.padding(.top, 24)
                        }

                    }.padding(.top, 42)

                Spacer()
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }

    }
}
