//
//  PeopleInHouseScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import Combine
import SwiftUI
import NavigationStack

enum PeopleOptions: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five

    var displayText: String {
        switch self {
        case .one:
            return "1 Person"
        case .two:
            return "2 People"
        case .three:
            return "3 People"
        case .four:
            return "4 People"
        case .five:
            return "5 People"
        }
    }

    var emoji: String {
        switch self {
        case .one:
            return "☝️"
        case .two:
            return "✌️"
        case .three:
            return "🏠"
        case .four:
            return "🏡"
        case .five:
            return "🏘"
        }
    }
}

struct PeopleInHouseScreen: View {

    private var options: [TileView<Int>.ViewModel] {
        return PeopleOptions
            .allCases
            .map { [TileView<Int>.ViewModel(text: $0.displayText, emoji: $0.emoji, underlyingValue: $0.rawValue)] }
            .reduce([TileView<Int>.ViewModel](), +)
    }

    @State private var selectedPeepsString: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var selectedPeepsInHouseValue = 0

    @ObservedObject private var peepsInHouseTileWallViewModel = TileWallView<Int>.ViewModel(tiles: [TileView<Int>.ViewModel]())

    let router: HouseSettingsRouter

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How many people live in your household?", description: "The information you enter here will only be used to calculate your electricity, gas and water usage. No information will be shared.")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                TileWallView(viewModel: peepsInHouseTileWallViewModel, selectedString: $selectedPeepsString, selectedUnderlyingValue: $selectedPeepsInHouseValue)

//                PushView(destination: SizeOfPropertyScreen(), isActive: $goToNextScreen, label: { EmptyView() })
            }.onChange(of: selectedPeepsString) { _ in

                print("underlying value is", selectedPeepsInHouseValue)

                persistPeopleInHouse(numOfPeople: selectedPeepsInHouseValue)
//                 Go to next tracking onboarding screen
                router.toHouseSize()
            }.onAppear {
                peepsInHouseTileWallViewModel.tiles = options
            }
        }

    }

    private func persistPeopleInHouse(numOfPeople: Int) {
        let user = PersistanceController.shared.fetchUser()
        user.peepsInHouse = Int64(numOfPeople)
        PersistanceController.shared.save()
    }

}

//struct PeopleInHouseScreen_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        let navigationStack: NavigationStack
//                NavigationStackView(navigationStack: navigationStack) {
//                    PeopleInHouseScreen(router: HouseSettingsRouter(navStack: <#NavigationStack#>))
//                }
//    }
//}
