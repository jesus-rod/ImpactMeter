//
//  UtilityTracking.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 18.04.21.
//

import SwiftUI
import NavigationStack

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
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                let tileOne = TileView<AnyHashable>.ViewModel(text: "Water", emoji: "💧", underylingValue: AnyHashable(Utilities.water))
                let tileTwo = TileView<AnyHashable>.ViewModel(text: "Electricity", emoji: "⚡️", underylingValue: AnyHashable(Utilities.electricity))
                let tileThree = TileView<AnyHashable>.ViewModel(text: "Gas", emoji: "🔥", underylingValue: AnyHashable(Utilities.gas))

                let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: [tileOne, tileTwo, tileThree])

                TileWallView(viewModel: tileWallVm,
                             selectedValue: $selectedUtility,
                             selectedUnderlyingValue: $selectedUtilityToStore)

                PushView(destination: UtilityTrackingView(), isActive: $goToNextScreen, label: { EmptyView() })
            }.onChange(of: selectedUtility) { _ in
                // Store selected year
                print("underlying value is", selectedUtilityToStore)
    //            carbonTrackingData. = selectedYear
                // Go to next tracking onboarding screen
                goToNextScreen = true
            }
        }
    }
}

struct UtilityTrackingView: View {

    @State var utilityText: String = ""
    @State var goToNextScreen: Bool = false

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How much electricity does your household consume?", description: "")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 24) {
                TitleAndDescriptionView(viewModel: titleVm)

                let suffixTvVm = PrimarySuffixableTextField.ViewModel(topPlaceholder: "Consumption", bottomPlaceholder: "This many", stickyText: "kWh")
                PrimarySuffixableTextField(viewModel: suffixTvVm, currentText: $utilityText, keyboardType: .phonePad)

                Spacer()

                PushView(destination: UtilityTrackingSummaryScreen(),
                               isActive: $goToNextScreen,
                               label: { Spacer() })

                PrimaryButton(title: "Confirm") {
                    validateUtility(withSize: utilityText)
                }
                .keyboardAdaptive()
            }
        }
    }

    private func validateUtility(withSize size: String) {
        goToNextScreen = true
    }
}

struct UtilityTrackingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UtilityTrackingScreen()
    }
}
