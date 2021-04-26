//
//  CountryInputView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct CountryInputView: View {
    @EnvironmentObject var user: LegacyUser
    private let allCountries: [Country] = CountriesGenerator().getCountries()

    let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Where do you live right now?",
                                                           description: "This is to determine the average for your region. None of your personal data will be shared.")
    let textInputViewModel = PrimaryTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country")

    private func makeCountryTilewall() -> TileWallView<AnyHashable>.ViewModel {
        let filteredCountries = allCountries.filter {
            $0.name.contains(user.country)
        }

        let tilesVm: [TileView<AnyHashable>.ViewModel] = filteredCountries.map { country in
            TileView.ViewModel(text: country.name, emoji: country.flag, underylingValue: AnyHashable(country.name))
        }
        return TileWallView.ViewModel(tiles: tilesVm)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleAndDescriptionView(viewModel: titleViewModel)
                .padding([.top], 80)
            PrimaryTextView(viewModel: textInputViewModel, currentText: $user.country, keyboardType: .webSearch)
                .padding([.top], 44)
            TileWallView(viewModel: makeCountryTilewall(), selectedValue: $user.country, selectedUnderlyingValue: .constant(""))
                .padding([.top], 24)
            Spacer()
        }
    }
}

struct CountryInputView_Previews: PreviewProvider {
    static var previews: some View {
        CountryInputView()
    }
}
