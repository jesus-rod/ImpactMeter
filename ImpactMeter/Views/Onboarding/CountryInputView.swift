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
//    @Published private var searchQuery = ""
//    private var searchCancellable: AnyCancellable?
//    @State private var shouldShowCountrySummary: Bool = false

    var body: some View {
        AppScreen(showBackButton: showBackButton) {
            VStack(alignment: .leading, spacing: 0) {
                TitleAndDescriptionView(viewModel: titleViewModel)
                PrimaryTextView(viewModel: textInputViewModel, currentText: $searchQuery, keyboardType: .webSearch)
                    .padding([.top], 44)
                TileWallView(viewModel: makeCountryTilewall(), selectedString: $user.country, selectedUnderlyingValue: $selectedCountry)
                    .padding([.top], 24)
                Spacer()
            }.onChange(of: selectedCountry) { _ in
//                shouldShowCountrySummary = true
//                PushView(destination: CountrySummary(), isActive: self.$shouldShowCountrySummary, label: { EmptyView() })
            }.keyboardAdaptive()
        }
    }

    private func makeCountryTilewall() -> TileWallView<String>.ViewModel {
        let allCountries = CountriesGenerator().getCountries()
        let filteredCountries = allCountries.filter { country in
            country.name.contains(searchQuery)
        }

        let tilesVm: [TileView<String>.ViewModel] = filteredCountries.map { country in
            TileView.ViewModel(text: country.name, emoji: country.flag, underylingValue: country.name)
        }
        return TileWallView<String>.ViewModel(tiles: tilesVm)
    }
}

struct CountryInputView_Previews: PreviewProvider {
    static var previews: some View {
        CountryInputView(showBackButton: true)
    }
}
