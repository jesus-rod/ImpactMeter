//
//  TileWallView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI
import Combine
import Collections

struct TileWallView<T: Hashable>: View {

    class ViewModel: ObservableObject {
        @Published var tiles = OrderedSet<TileView<T>.ViewModel>()
        @Published var validatedTiles = OrderedSet<TileView<T>.ViewModel>()
        private var cancellablePipeline: AnyCancellable?

        init(tiles: [TileView<T>.ViewModel], shouldDebounce: Bool = false) {
            cancellablePipeline = $tiles
                .removeDuplicates()
                .debounce(for: shouldDebounce ? 0.3 : 0, scheduler: RunLoop.main)
                .sink { [unowned self] value in
                    self.validatedTiles = value
                }
        }
    }

    @ObservedObject private var viewModel: ViewModel
    @Binding var selectedString: String
    @Binding var selectedUnderlyingValue: T

    internal init(viewModel: TileWallView<T>.ViewModel,
                  selectedString: Binding<String>,
                  selectedUnderlyingValue: Binding<T>) {
        self.viewModel = viewModel
        self._selectedString = selectedString
        self._selectedUnderlyingValue = selectedUnderlyingValue
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            FlexibleView(
                data: viewModel.validatedTiles,
                spacing: 10,
                alignment: .leading
            ) { tileInfo in
                TileView(viewModel: tileInfo,
                         selectedTag: $selectedString,
                         isSelected: isSelected(tileText: tileInfo.text),
                         selectedUnderlyingValue: $selectedUnderlyingValue)
            }
        }.padding([.horizontal, .bottom], 16)
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
            TileView<AnyHashable>.ViewModel(text: country.name, emoji: country.flag, underlyingValue: AnyHashable(country.name))
        }
        let tileWallViewModel = TileWallView<AnyHashable>.ViewModel(tiles: tilesVm)
        TileWallView(viewModel: tileWallViewModel, selectedString: .constant(""), selectedUnderlyingValue: .constant(""))
    }
}
