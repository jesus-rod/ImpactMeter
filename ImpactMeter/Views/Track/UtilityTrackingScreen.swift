//
//  UtilityTracking.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 18.04.21.
//

import SwiftUI

struct UtilityTrackingScreen: View {

    enum Utilities: String {
        case water
        case electricity
        case gas
        case unknown
    }

    @EnvironmentObject var carbonTrackingData: CarbonTrackingData
    @State private var selectedUtility: String = Utilities.unknown.rawValue
    @State private var goToNextScreen: Bool = false
    @State private var selectedUtilityToStore = AnyHashable(Utilities.unknown)

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Which utility would you like to track?", description: "")
        VStack(alignment: .leading, spacing: 42) {
            TitleAndDescriptionView(viewModel: titleVm)

            let tileOne = TileView<AnyHashable>.ViewModel(text: "Water", emoji: "💧", underylingValue: AnyHashable(Utilities.water))
            let tileTwo = TileView<AnyHashable>.ViewModel(text: "Electricity", emoji: "⚡️", underylingValue: AnyHashable(Utilities.electricity))
            let tileThree = TileView<AnyHashable>.ViewModel(text: "Gas", emoji: "🔥", underylingValue: AnyHashable(Utilities.gas))

            let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: [tileOne, tileTwo, tileThree])

            TileWallView(viewModel: tileWallVm,
                         selectedValue: $selectedUtility,
                         selectedUnderlyingValue: $selectedUtilityToStore)

            NavigationLink(destination: UtilityTrackingView(), isActive: $goToNextScreen, label: { EmptyView() })
        }.onChange(of: selectedUtility) { _ in
            // Store selected year
            print("underlying value is", selectedUtilityToStore)
//            carbonTrackingData. = selectedYear
            // Go to next tracking onboarding screen
            goToNextScreen = true
            
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct UtilityTrackingView: View {

    @State var utilityText: String = ""
    @State var goToNextScreen: Bool = false

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How much electricity does your household consume?", description: "")

        VStack(alignment: .leading, spacing: 24) {
            TitleAndDescriptionView(viewModel: titleVm)

            let suffixTvVm = PrimarySuffixableTextField.ViewModel(topPlaceholder: "Consumption", bottomPlaceholder: "This many", stickyText: "kWh")
            PrimarySuffixableTextField(viewModel: suffixTvVm, currentText: $utilityText, keyboardType: .phonePad)

            Spacer()

            PrimaryButton(title: "Confirm", action: {
                validateUtility(withSize: utilityText)
            })

            NavigationLink(destination: UtilityTrackingSummaryScreen(),
                           isActive: $goToNextScreen,
                           label: { EmptyView() })
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }

    private func validateUtility(withSize size: String) {
        goToNextScreen = true
    }
}

struct UtilityTrackingSummaryScreen: View {
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

                        PrimaryButton(title: "Okay") {
                            print("dismissSummary")
                        }.padding(.top, 24)
                    }.padding(.top, 42)

                Spacer()
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }

    }
}

struct UtilityTrackingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UtilityTrackingScreen()
    }
}
