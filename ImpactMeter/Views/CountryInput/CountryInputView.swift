//
//  CountryInputView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct CountryInputView: View {

    @EnvironmentObject var user: User

    let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Where do you live right now?",
                                                      description: "This is to determine the average for your region. None of your personal data will be shared.")
    let textInputViewModel = PrimaryTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country")



    func makeCountryTilewall() -> TileWallView.ViewModel {
        let countries: [Country] = CountriesGenerator().getCountries()
        let filteredCountries = countries.filter({
            $0.name.contains(user.country.capitalized)
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
            PrimaryTextView(viewModel: textInputViewModel)
                .padding([.top], 44)
            TileWallView(viewModel: makeCountryTilewall())
                .padding([.top], 24)
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CountryInputView_Previews: PreviewProvider {
    static var previews: some View {
        CountryInputView()
    }
}
