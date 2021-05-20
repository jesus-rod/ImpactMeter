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

    // Categories hardcoded 
    static func makeTrackingCategories() -> [TileView<String>.ViewModel] {
        var categories = [TileView<String>.ViewModel]()
        TrackingCategory.allCases.forEach { category in
            let tile = TileView<String>.ViewModel(text: category.rawValue.capitalized, emoji: category.emoji, underylingValue: category.rawValue)
            categories.append(tile)
        }
        return categories
    }

    @ObservedObject private var activitiesTileWallViewModel = TileWallView<String>.ViewModel(tiles: [TileView<String>.ViewModel]())

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

                    TileWallView(viewModel: activitiesTileWallViewModel, selectedString: $selectedActivity, selectedUnderlyingValue: $selectedActivity)

                    // Pushing Views (Navigation)
                    PushView(destination: PeopleInHouseScreen(), isActive: $goToNextScreen, label: { EmptyView() })
                    PushView(destination: SettingsView(), isActive: $isShowingSettings) { EmptyView() }
                }.onChange(of: selectedActivity) { _ in
                    goToNextScreen = true
                }.onAppear {
                    activitiesTileWallViewModel.tiles = TrackNewActivityScreen.makeTrackingCategories()
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
