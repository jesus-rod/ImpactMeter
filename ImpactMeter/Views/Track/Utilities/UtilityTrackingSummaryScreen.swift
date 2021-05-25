//
//  UtilityTrackingSummaryScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack

struct SummaryItem: Identifiable {
    var id = UUID()
    let valueToShow: String
}

struct UtilityTrackingSummaryScreen: View {

    struct ViewModel {
        let titleViewModel: TitleAndDescriptionView.ViewModel
        let circleViewModel: CircleInCircleView.ViewModel
        let tipOneViewModel: TipView.ViewModel
        let tipTwoViewModel: TipView.ViewModel
    }

    let summary: SummaryItem

    private let viewModel: ViewModel

    init(utility: Utility, item: SummaryItem) {
        self.summary = item

        func makeViewModel(utility: Utility) -> UtilityTrackingSummaryScreen.ViewModel {
            let summaryTitleVm = TitleAndDescriptionView.ViewModel(title: "Calculated emissions",
                                                                   description: "Calculating your personal footprint is done automatically and it will be compared to average levels in your area.")
            let circleViewModel = CircleInCircleView.ViewModel(circleTitle: "\(item.valueToShow)", circleSubtitle: "your \(utility.displayText) consumption", circleColor: Color.orange, circleUndertextTitle: "Average consumption", circleUndertextSubTitle: "in your area")

            let tipOneViewModel = TipView.ViewModel(emoji: "💡", tip: "Smart plugs are an initial investment but they help reduce *vampire energy consumption up to 87%*")

            let tipTwoViewModel = TipView.ViewModel(emoji: "💤", tip: "A lot of modern devices *have super-low energy standby mode settings.* Try switching to this mode when possible.")

            return UtilityTrackingSummaryScreen.ViewModel(titleViewModel: summaryTitleVm, circleViewModel: circleViewModel, tipOneViewModel: tipOneViewModel, tipTwoViewModel: tipTwoViewModel)
        }
        self.viewModel = makeViewModel(utility: utility)

    }

    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CircleInCircleView(titleViewModel: viewModel.titleViewModel, viewModel: viewModel.circleViewModel)
                    .padding(.top, 24)

                VStack(alignment: .leading, spacing: 24) {

                    Text("Worth considering")
                        .font(.title3)
                        .bold()
                        .padding([.bottom, .horizontal], 24)

                    TipView(viewModel: viewModel.tipOneViewModel)
                    TipView(viewModel: viewModel.tipTwoViewModel)

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
