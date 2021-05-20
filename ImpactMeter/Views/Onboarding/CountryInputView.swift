//
//  CountryInputView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI
import NavigationStack
import Combine

struct CountryInputView: View {

    let showBackButton: Bool

    @EnvironmentObject var user: LegacyUser

    private let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Where do you live right now?",
                                                           description: "This is to determine the average for your region. None of your personal data will be shared.")
    private let textInputViewModel = PrimaryTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country")

    @State private var selectedCountry: String = ""
    @State private var searchQuery: String = ""

    @StateObject private var tileWallVm = TileWallView<String>.ViewModel(tiles: [TileView<String>.ViewModel]())

    var body: some View {
        AppScreen(showBackButton: showBackButton) {
            VStack(alignment: .leading, spacing: 0) {
                TitleAndDescriptionView(viewModel: titleViewModel)
                PrimaryTextView(viewModel: textInputViewModel, currentText: $searchQuery, keyboardType: .webSearch)
                    .padding([.top], 44)
                TileWallView(viewModel: tileWallVm, selectedString: $user.country, selectedUnderlyingValue: $selectedCountry)
                    .padding([.top], 24)
                Spacer()
            }.onChange(of: searchQuery) { countryInputText in
                updateCountryTilewall(with: countryInputText)
//                shouldShowCountrySummary = true
//                PushView(destination: CountrySummary(), isActive: self.$shouldShowCountrySummary, label: { EmptyView() })
            }.keyboardAdaptive()
        }
    }

    private func updateCountryTilewall(with countryInput: String) {
         let allCountries = CountriesGenerator().getCountries()
        let filteredCountries = allCountries.filter { country in
            country.name.lowercased().contains(countryInput.lowercased())
        }

        let updatedTiles: [TileView<String>.ViewModel] = filteredCountries.map { country in
            TileView.ViewModel(text: country.name, emoji: country.flag, underylingValue: country.name)
        }

        tileWallVm.tiles = updatedTiles
    }

}

struct CountryInputView_Previews: PreviewProvider {
    static var previews: some View {
        CountryInputView(showBackButton: true)
    }
}
