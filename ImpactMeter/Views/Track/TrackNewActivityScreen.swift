//
//  TrackNewActivityScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack

enum TrackingCategory: String, CaseIterable {
    case travel
    case utility

    var emoji: String {
        switch self {
        case .travel:
            return "✈️"
        case .utility:
            return "🚰"
        }
    }
}

struct TrackNewActivityScreen: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var selectedActivity: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var isShowingSettings: Bool = false
    @State private var selectedPeepsInHouse = AnyHashable(0)

    // Categories hardcoded
    private var trackingCategories: [TileView<AnyHashable>.ViewModel] {
        var categories = [TileView<AnyHashable>.ViewModel]()
        TrackingCategory.allCases.forEach { category in
            let tile = TileView<AnyHashable>.ViewModel(text: category.rawValue.capitalized, emoji: category.emoji, underylingValue: AnyHashable(1))
            categories.append(tile)
        }
        return categories
    }

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track new activity 🌿", description: "")
        VStack(alignment: HorizontalAlignment.leading, spacing: 0) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .modifier(NavigationLinkStyle())
            }
            AppScreen {
                VStack(alignment: .leading, spacing: 42) {
                    VStack {
                        TitleAndDescriptionView(viewModel: titleVm)
                        Button(action: {
                            isShowingSettings = true
                        }, label: {
                            LinkImageView()
                                .offset(y: -20)
                        })
                    }
                    let tileWallVm = TileWallView<AnyHashable>.ViewModel(tiles: trackingCategories)
                    TileWallView(viewModel: tileWallVm, selectedString: $selectedActivity, selectedUnderlyingValue: $selectedPeepsInHouse)

                    PushView(destination: PeopleInHouseScreen(), isActive: $goToNextScreen, label: { EmptyView() })

                    PushView(destination: SettingsView(), isActive: $isShowingSettings) { EmptyView() }
                }.onChange(of: selectedActivity) { _ in
                    print("underlying value is", selectedPeepsInHouse)
                    goToNextScreen = true
                }
            }

        }
    }

}

struct TrackNewActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrackNewActivityScreen()
    }
}
