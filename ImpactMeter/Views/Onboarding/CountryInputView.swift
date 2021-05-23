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

    let router: CountrySettingsRouter

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
            }.onChange(of: selectedCountry) { value in
                LoggingController.shared.log.info("User selected \(value)")

                saveCountryOfUser(value, completion: {
                    // Add some loading here
                    router.toCountrySummary()
                })
            }.keyboardAdaptive()
        }
    }

    private func updateCountryTilewall(with countryInput: String) {
        let allCountries = CountriesGenerator().getCountries()
        let filteredCountries = allCountries.filter { country in
            country.name.lowercased().contains(countryInput.lowercased())
        }

        let updatedTiles: [TileView<String>.ViewModel] = filteredCountries.map { country in
            TileView.ViewModel(text: country.name, emoji: country.flag, underlyingValue: country.code)
        }

        tileWallVm.tiles = updatedTiles
    }

    private func saveCountryOfUser(_ country: String, completion: @escaping () -> Void) {
        let user = PersistanceController.shared.fetchUser()
        user.country = country
        PersistanceController.shared.save { error in
            if let err = error {
                print("there was an error saving the country of the user \(err.localizedDescription)")
                return
            }
            completion()
        }
    }
}

struct CountryInputView_Previews: PreviewProvider {
    static var previews: some View {
        CountryInputView(showBackButton: true, router: CountrySettingsRouter(navStack: NavigationStack()))
    }
}
