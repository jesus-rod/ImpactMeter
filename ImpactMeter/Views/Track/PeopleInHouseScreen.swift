//
//  PeopleInHouseScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import SwiftUI

struct PeopleInHouseScreen: View {

    @EnvironmentObject var user: User

    @State private var selectedCountry: String = ""
    @State private var goToNextScreen: Bool = false

    var body: some View {
//        if (selectedCountry.isEmpty) {
            let titleVm = TitleAndDescriptionView.ViewModel(title: "How many people live in your household?", description: "The information you enter here will only be used to calculate your electricity, gas and water usage. No information will be shared.")
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                let tileOne = TileView.ViewModel(text: "1 Person", emoji: "☝️")
                let tileTwo = TileView.ViewModel(text: "2 People", emoji: "✌️")
                let tileThree = TileView.ViewModel(text: "3 People", emoji: "🏠")
                let tileFour = TileView.ViewModel(text: "4 People", emoji: "🏡")
                let tileFive = TileView.ViewModel(text: "5 or more", emoji: "🏘")
                let tileWallVm = TileWallView.ViewModel(tiles: [tileOne, tileTwo, tileThree, tileFour, tileFive])
                TileWallView(viewModel: tileWallVm, selectedValue: $selectedCountry)

                NavigationLink(destination: NumberOfPeopleScreen(), isActive: $goToNextScreen, label: { EmptyView() })
            }.onChange(of: selectedCountry) { value in
                // Store value of peeps in da house

                // Go to next tracking onboarding screen
                goToNextScreen = true
            }.navigationTitle("")
    }
}

struct PeopleInHouseScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeopleInHouseScreen()
    }
}
