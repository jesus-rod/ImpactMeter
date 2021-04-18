//
//  PeopleInHouseScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import Combine
import SwiftUI

struct PeopleInHouseScreen: View {
    @EnvironmentObject var carbonTrackingData: CarbonTrackingData

    @State private var selectedCountry: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var selectedPeepsInHouse = AnyHashable(0)

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How many people live in your household?", description: "The information you enter here will only be used to calculate your electricity, gas and water usage. No information will be shared.")
        VStack(alignment: .leading, spacing: 42) {
            TitleAndDescriptionView(viewModel: titleVm)

            let tileOne = TileView<AnyHashable>.ViewModel(text: "1 Person", emoji: "☝️", underylingValue: AnyHashable(1))
            let tileTwo = TileView<AnyHashable>.ViewModel(text: "2 People", emoji: "✌️", underylingValue: AnyHashable(2))
            let tileThree = TileView<AnyHashable>.ViewModel(text: "3 People", emoji: "🏠", underylingValue: AnyHashable(3))
            let tileFour = TileView<AnyHashable>.ViewModel(text: "4 People", emoji: "🏡", underylingValue: AnyHashable(4))
            let tileFive = TileView<AnyHashable>.ViewModel(text: "5 or more", emoji: "🏘", underylingValue: AnyHashable(5))
            let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: [tileOne, tileTwo, tileThree, tileFour, tileFive])
            TileWallView(viewModel: tileWallVm, selectedValue: $selectedCountry, selectedUnderlyingValue: $selectedPeepsInHouse)

            NavigationLink(destination: SizeOfPropertyScreen(), isActive: $goToNextScreen, label: { EmptyView() })
        }.onChange(of: selectedCountry) { _ in
            // Store value of peeps in da house
            print("underlying value is", selectedPeepsInHouse)
            carbonTrackingData.peepsInHouse = selectedPeepsInHouse.base as? Int ?? 0
            // Go to next tracking onboarding screen
            goToNextScreen.toggle()
        }.navigationTitle("")
    }
}

struct PeopleInHouseScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeopleInHouseScreen()
    }
}
