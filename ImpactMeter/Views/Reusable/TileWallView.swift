//
//  TileWallView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileWallView<T: Hashable>: View {

    struct ViewModel {
        let tiles: [TileView<T>.ViewModel]
    }

    let viewModel: ViewModel
    @Binding var selectedString: String
    @Binding var selectedUnderlyingValue: T

    internal init(viewModel: TileWallView<T>.ViewModel,
                  selectedString: Binding<String>,
                  selectedUnderlyingValue: Binding<T>) {
        self.viewModel = viewModel
        self._selectedString = selectedString
        self._selectedUnderlyingValue = selectedUnderlyingValue
    }

//    let selectionType: SelectionType = .single
//
//    enum SelectionType {
//        case single
//        case multiple
//    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            FlexibleView(
                data: viewModel.tiles,
                spacing: 10,
                alignment: .leading
            ) { tileInfo in
                TileView(viewModel: tileInfo,
                         selectedTag: $selectedString,
                         isSelected: isSelected(tileText: tileInfo.text),
                         selectedUnderlyingValue: $selectedUnderlyingValue)
            }
        }.padding([.leading, .trailing, .bottom], 16)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
    }

    private func isSelected(tileText: String) -> Bool {
        return selectedString == tileText
    }
}

struct TileWallView_Previews: PreviewProvider {
    static var previews: some View {
        let countries = CountriesGenerator().getCountries()
        let tilesVm = countries.map { country in
            TileView<AnyHashable>.ViewModel(text: country.name, emoji: country.flag, underylingValue: AnyHashable(country.name))
        }
        let tileWallViewModel = TileWallView<AnyHashable>.ViewModel(tiles: tilesVm)
        TileWallView(viewModel: tileWallViewModel, selectedString: .constant(""), selectedUnderlyingValue: .constant(""))
    }
}
