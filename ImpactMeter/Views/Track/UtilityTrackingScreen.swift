//
//  UtilityTracking.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 18.04.21.
//

import SwiftUI
import NavigationStack

enum UtilityOptions: String, TileOptions {
    case water
    case electricity
    case gas

    var displayText: String {
        switch self {
        case .water:
            return "Water"
        case .electricity:
            return "Electricity"
        case .gas:
            return "Gas"
        }
    }

    var emoji: String {
        switch self {
        case .water: return "💧"
        case .electricity: return "⚡️"
        case .gas: return "🔥"
        }
    }

    var utility: Utility {
        switch self {
        case .water:
            return .water
        case .electricity:
            return .electricity
        case .gas:
            return .gas
        }
    }

}

struct UtilityTrackingScreen: View {

    @State private var selectedUtility = Utility.unknown.rawValue
    @State private var goToNextScreen: Bool = false
    @State private var selectedUtilityToStore = Utility.unknown

    private var options: Set<TileView<Utility>.ViewModel> {
        return Set(UtilityOptions.allCases
                .map { TileView<Utility>.ViewModel(text: $0.displayText, emoji: $0.emoji, underlyingValue: $0.utility) })
    }

    @ObservedObject private var utilitiesTileWallViewModel = TileWallView<Utility>.ViewModel(tiles: [TileView<Utility>.ViewModel]())

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Which utility would you like to track?", description: "")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                TileWallView(viewModel: utilitiesTileWallViewModel,
                             selectedString: $selectedUtility,
                             selectedUnderlyingValue: $selectedUtilityToStore)

                PushView(destination: UtilityTrackingView(utility: selectedUtilityToStore), isActive: $goToNextScreen, label: { EmptyView() })
            }.onChange(of: selectedUtilityToStore) { _ in
                print("underlying value is", selectedUtilityToStore)
                goToNextScreen = true
            }.onAppear {
                utilitiesTileWallViewModel.tiles = options
            }
        }
    }
}

struct UtilityTrackingView: View {

    @State var utilityText: String = ""
    @State private var goToNextScreen: Bool = false
    @EnvironmentObject private var navigationStack: NavigationStack
    @Environment(\.presentationMode) var presentationMode

    @State private var summaryItem: SummaryItem?

    let utility: Utility

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How much \(utility.displayText) does your household consume?", description: "")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 24) {
                TitleAndDescriptionView(viewModel: titleVm)

                let suffixTvVm = PrimarySuffixableTextField.ViewModel(topPlaceholder: "Consumption", bottomPlaceholder: "This many", stickyText: utility.unit)
                PrimarySuffixableTextField(viewModel: suffixTvVm, currentText: $utilityText, keyboardType: .phonePad)

                Spacer()

                PrimaryButton(title: "Confirm") {
                    validateUtility(with: utilityText)
                }.keyboardAdaptive()
            }
        }.sheet(item: $summaryItem, onDismiss: {
            presentationMode.wrappedValue.dismiss()
        }, content: { detailInfo in
            UtilityTrackingSummaryScreen(utility: utility, item: detailInfo)
        })
    }

    private func validateUtility(with value: String) {
        storeActivity(utility: utility, storedValue: value)
        summaryItem = SummaryItem(valueToShow: value)
        goToNextScreen = true
    }

    private func storeActivity(utility: Utility, storedValue: String) {
        let amount = storedValue.components(separatedBy: " ")
        let firstPart = amount.first ?? ""
        // convert first part to Integer
        let amountIntegerValue = Int(firstPart) ?? 0
        PersistanceController.shared.addTrackedActivity(amount: amountIntegerValue, trackActivity: utility)
    }
}

struct UtilityTrackingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UtilityTrackingScreen()
    }
}
