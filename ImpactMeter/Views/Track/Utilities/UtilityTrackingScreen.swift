//
//  UtilityTracking.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 18.04.21.
//

import SwiftUI
import NavigationStack
import Collections

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

    private var options: OrderedSet<TileView<Utility>.ViewModel> {
        return OrderedSet(UtilityOptions.allCases
                .map { TileView<Utility>.ViewModel(text: $0.displayText, emoji: $0.emoji, underlyingValue: $0.utility) })
    }

    @ObservedObject private var utilitiesTileWallViewModel = TileWallView<Utility>.ViewModel(tiles: [TileView<Utility>.ViewModel]())

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Which utility would you like to track?", description: "")
        AppScreen(.withBackButton) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                TileWallView(viewModel: utilitiesTileWallViewModel,
                             selectedString: $selectedUtility,
                             selectedUnderlyingValue: $selectedUtilityToStore)

                PushView(destination: UtilityTrackingInputScreen(utility: selectedUtilityToStore), isActive: $goToNextScreen, label: { EmptyView() })
            }.onChange(of: selectedUtilityToStore) { _ in
                print("underlying value is", selectedUtilityToStore)
                goToNextScreen = true
            }.onAppear {
                utilitiesTileWallViewModel.tiles = options
            }
        }
    }
}

struct UtilityTrackingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UtilityTrackingScreen()
    }
}
