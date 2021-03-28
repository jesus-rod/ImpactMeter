//
//  CountryInputView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct CountryInputView: View {

    @EnvironmentObject var user: User
    private let allCountries: [Country] = CountriesGenerator().getCountries()


    let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Where do you live right now?",
                                                           description: "This is to determine the average for your region. None of your personal data will be shared.")
    let textInputViewModel = PrimaryTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country")


    private func makeCountryTilewall() -> TileWallView.ViewModel {
        let filteredCountries = allCountries.filter({
            $0.name.contains(user.country)
        })

        let tilesVm: [TileView.ViewModel] = filteredCountries.map { (country) in
            return TileView.ViewModel(text: country.name, emoji: country.flag)
        }
        return TileWallView.ViewModel(tiles: tilesVm)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleAndDescriptionView(viewModel: titleViewModel)
                .padding([.top], 80)
            PrimaryTextView(viewModel: textInputViewModel, currentText: $user.country)
                .padding([.top], 44)
            TileWallView(viewModel: makeCountryTilewall(), selectedValue: $user.country)
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
