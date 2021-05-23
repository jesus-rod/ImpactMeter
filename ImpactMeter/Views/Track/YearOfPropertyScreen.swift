//
//  YearOfPropertyScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 17.04.21.
//

import SwiftUI
import NavigationStack

enum PropertyYearOptions: String, TileOptions {
    case yearRangeOne = "2000-2020"
    case yearRangeTwo = "1980-2000"
    case yearRangeThree = "1960-1980"
    case yearRangeFour = "1940-1960"
    case yearRangeFive = "1920-1940"
    case yearRangeSix = "Pre 1920"

    var displayText: String {
        switch self {
        case .yearRangeOne:
            return "1 Person"
        case .yearRangeTwo:
            return "2 People"
        case .yearRangeThree:
            return "3 People"
        case .yearRangeFour:
            return "4 People"
        case .yearRangeFive:
            return "5 People"
        case .yearRangeSix:
            return "6 People"
        }
    }

    var emoji: String {
        switch self {
        case .yearRangeOne:
            return "👶"
        case .yearRangeTwo:
            return "🏠"
        case .yearRangeThree:
            return "🏙"
        case .yearRangeFour:
            return "⛲️"
        case .yearRangeFive:
            return "🏰"
        case .yearRangeSix:
            return "🏛"
        }
    }
}

struct YearOfPropertyScreen: View {

    @State private var selectedYear: String = ""
    @State private var selectedYearToStore = ""

    private var options: Set<TileView<String>.ViewModel> {
        Set(PropertyYearOptions.allCases.map { TileView<String>.ViewModel(text: $0.displayText, emoji: $0.emoji, underlyingValue: $0.rawValue) })
    }

    @ObservedObject private var yearOfPropertyTileWallViewModel = TileWallView<String>.ViewModel(tiles: [TileView<String>.ViewModel]())

    let router: HouseSettingsRouter

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "When was the structure built?", description: "")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)
                TileWallView(viewModel: yearOfPropertyTileWallViewModel, selectedString: $selectedYear, selectedUnderlyingValue: $selectedYearToStore)
            }.onChange(of: selectedYear) { _ in
                // Store selected year
                print("underlying value is", selectedYearToStore)

                saveYearOfProperty(selectedYear, completion: {
                    router.popBackToSettings()
                })

            }.onAppear {
                yearOfPropertyTileWallViewModel.tiles = options
            }
        }
    }

    private func saveYearOfProperty(_ yearOfProperty: String, completion: @escaping () -> Void) {
        let user = PersistanceController.shared.fetchUser()
        user.houseYear = yearOfProperty
        PersistanceController.shared.save { error in
            if let err = error {
                print("there was an error saving size of property \(err.localizedDescription)")
                return
            }
            completion()
        }
    }
}

struct YearOfPropertyScreen_Previews: PreviewProvider {
    static var previews: some View {
        YearOfPropertyScreen(router: HouseSettingsRouter(navStack: NavigationStack()))
    }
}
