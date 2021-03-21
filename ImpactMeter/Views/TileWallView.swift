//
//  TileWallView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileWallView: View {

    let viewModel: ViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.tiles, id: \.self) { tileInfo in
                    TileView(viewModel: tileInfo)

                }
            }.padding([.leading, .trailing, .bottom], 16)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                    alignment: .leading)
        }
    }


}

extension TileWallView {

    struct ViewModel {
        let tiles: [TileView.ViewModel]
    }
}

struct TileWallView_Previews: PreviewProvider {
    static var previews: some View {
        let countries = CountriesGenerator().getCountries()
        let tilesVm = countries.map { (country) in
            return TileView.ViewModel(text: country.name, emoji: country.flag)
        }
        let vm = TileWallView.ViewModel(tiles: tilesVm)
        TileWallView(viewModel: vm)
    }
}
