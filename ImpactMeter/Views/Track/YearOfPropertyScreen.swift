//
//  YearOfPropertyScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 17.04.21.
//

import SwiftUI
import NavigationStack

struct YearOfPropertyScreen: View {

    @EnvironmentObject var carbonTrackingData: CarbonTrackingData
    @State private var selectedYear: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var selectedYearToStore = AnyHashable(0)

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "When was the structure built?", description: "")
        VStack(alignment: .leading, spacing: 42) {
            TitleAndDescriptionView(viewModel: titleVm)

            let tileOne = TileView<AnyHashable>.ViewModel(text: "2000-2020", emoji: "👶", underylingValue: AnyHashable("2000-2020"))
            let tileTwo = TileView<AnyHashable>.ViewModel(text: "1980-2000", emoji: "🏠", underylingValue: AnyHashable("1980-2000"))
            let tileThree = TileView<AnyHashable>.ViewModel(text: "1960-1980", emoji: "🏙", underylingValue: AnyHashable("1960-1980"))
            let tileFour = TileView<AnyHashable>.ViewModel(text: "1940-1960", emoji: "⛲️", underylingValue: AnyHashable("1940-1960"))
            let tileFive = TileView<AnyHashable>.ViewModel(text: "1920-1940", emoji: "🏰", underylingValue: AnyHashable("1920-1940"))
            let tileSix = TileView<AnyHashable>.ViewModel(text: "Pre 1920", emoji: "🏛", underylingValue: AnyHashable("Pre 1920"))

            let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: [tileOne, tileTwo, tileThree, tileFour, tileFive, tileSix])

            TileWallView(viewModel: tileWallVm, selectedValue: $selectedYear, selectedUnderlyingValue: $selectedYearToStore)

            PushView(destination: UtilityTrackingScreen(), isActive: $goToNextScreen, label: { EmptyView() })
        }.onChange(of: selectedYear) { _ in
            // Store selected year
            print("underlying value is", selectedYearToStore)
            carbonTrackingData.yearOfHouse = selectedYear
            // Go to next tracking onboarding screen
            goToNextScreen.toggle()
        }.navigationBarTitle("")
    }
}

struct YearOfPropertyScreen_Previews: PreviewProvider {
    static var previews: some View {
        YearOfPropertyScreen()
    }
}
