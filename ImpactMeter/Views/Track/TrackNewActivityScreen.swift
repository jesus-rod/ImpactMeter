//
//  TrackNewActivityScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack

struct TrackNewActivityScreen: View {
    @State private var selectedCountry: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var selectedPeepsInHouse = AnyHashable(0)

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track new activity 🌿", description: "")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                let tileOne = TileView<AnyHashable>.ViewModel(text: "Travel", emoji: "✈️", underylingValue: AnyHashable(1))
                let tileTwo = TileView<AnyHashable>.ViewModel(text: "Utilities", emoji: "🚰", underylingValue: AnyHashable(2))

                let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: [tileOne, tileTwo])
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

struct TrackNewActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrackNewActivityScreen()
    }
}
