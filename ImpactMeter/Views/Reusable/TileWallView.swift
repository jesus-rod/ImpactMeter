//
//  TileWallView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileWallView: View {

    let viewModel: ViewModel
    let selectionType: SelectionType = .single

    @State var selectedTiles = [TileView]()

    enum SelectionType {
        case single
        case multiple
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            FlexibleView(
              data: viewModel.tiles,
              spacing: 10,
            alignment: .leading
            ) { tileInfo in
                TileView(viewModel: tileInfo)
            }
        }.padding([.leading, .trailing, .bottom], 16)
            .frame(maxWidth: .infinity,
                    alignment: .leading)

    }

    private var anyTileIsSelected: Bool {
        return selectedTiles.count > 0
    }

    private func getSelectedTiles() {
        if selectionType == .single {

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
