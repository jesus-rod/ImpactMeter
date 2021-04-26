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

    private var options: [TileView<AnyHashable>.ViewModel<AnyHashable>] {
        var categories = [TileView<AnyHashable>.ViewModel<AnyHashable>]()
        PeopleOptions.allCases.forEach { option in
            let tile = TileView<AnyHashable>.ViewModel(text: option.displayText, emoji: option.emoji, underylingValue: AnyHashable(option.rawValue))
            categories.append(tile)
        }
        return categories
    }

    @EnvironmentObject var carbonTrackingData: CarbonTrackingData

    @State private var selectedPeepsString: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var selectedPeepsInHouseValue = AnyHashable(0)

    // Object Context
    @Environment(\.managedObjectContext) var moc
    // Fetch our user
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var users: FetchedResults<User>

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How many people live in your household?", description: "The information you enter here will only be used to calculate your electricity, gas and water usage. No information will be shared.")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)

                let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: options)
                TileWallView(viewModel: tileWallVm, selectedValue: $selectedPeepsString, selectedUnderlyingValue: $selectedPeepsInHouseValue)

                PushView(destination: SizeOfPropertyScreen(), isActive: $goToNextScreen, label: { EmptyView() })
            }.onChange(of: selectedPeepsString) { _ in
                // Store value of peeps in da house
                print("underlying value is", selectedPeepsInHouseValue)
                let peepsInHouse = selectedPeepsInHouseValue.base as? Int ?? 1
                let user = User(context: moc)
                user.peepsInHouse = Int16(peepsInHouse)

                do {
                    try self.moc.save()
                } catch {
                    print("Can't save this user!")
                }

                // Go to next tracking onboarding screen
                goToNextScreen.toggle()
            }.onAppear {
                print("# of Users found \(users.count)")
                print("Check if user has stored size of property")
                print(users.first?.peepsInHouse ?? "Not found (peepsInHouse)")
            }
        }

    }
}

struct PeopleInHouseScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeopleInHouseScreen()
    }
}
