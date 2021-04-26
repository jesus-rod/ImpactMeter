//
//  TrackNewActivityScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack

enum TrackingCategory: String, CaseIterable {
    case travel
    case utility

    var emoji: String {
        switch self {
        case .travel:
            return "✈️"
        case .utility:
            return "🚰"
        }
    }
}

struct TrackNewActivityScreen: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var selectedCountry: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var selectedPeepsInHouse = AnyHashable(0)

    // Categories hardcoded
    private var trackingCategories: [TileView<AnyHashable>.ViewModel<AnyHashable>] {
        var categories = [TileView<AnyHashable>.ViewModel<AnyHashable>]()
        TrackingCategory.allCases.forEach { category in
            let tile = TileView<AnyHashable>.ViewModel(text: category.rawValue.capitalized, emoji: category.emoji, underylingValue: AnyHashable(1))
            categories.append(tile)
        }
        return categories
    }

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track new activity 🌿", description: "")
        VStack(alignment: HorizontalAlignment.leading, spacing: 0) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .modifier(NavigationLinkStyle())
            }
            AppScreen {
                VStack(alignment: .leading, spacing: 42) {
                    TitleAndDescriptionView(viewModel: titleVm)

                    let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: trackingCategories)
                    TileWallView(viewModel: tileWallVm, selectedValue: $selectedCountry, selectedUnderlyingValue: $selectedPeepsInHouse)

                    PushView(destination: PeopleInHouseScreen(), isActive: $goToNextScreen, label: { EmptyView() })
                }.onChange(of: selectedCountry) { _ in
                    // Store value of peeps in da house
                    print("underlying value is", selectedPeepsInHouse)
                //            carbonTrackingData.peepsInHouse = selectedPeepsInHouse.base as? Int ?? 0
                    // Go to next tracking onboarding screen
                    goToNextScreen.toggle()
                }
            }

        }
    }

}

struct TrackNewActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrackNewActivityScreen()
    }
}
