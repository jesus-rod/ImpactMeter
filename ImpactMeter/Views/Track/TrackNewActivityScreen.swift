//
//  TrackNewActivityScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack
import Collections

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

    let navigationStack: NavigationStack

    @State private var selectedActivity: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var isShowingSettings: Bool = false

    // Categories hardcoded 
    private var trackingCategories: OrderedSet<TileView<String>.ViewModel> {
        return OrderedSet(TrackingCategory.allCases
                            .map { TileView<String>.ViewModel(text: $0.rawValue.capitalized,
															  emoji: $0.emoji,
															  underlyingValue: $0.rawValue) })
    }

    @ObservedObject private var activitiesTileWallViewModel = TileWallView<String>.ViewModel(tiles: [TileView<String>.ViewModel]())

	let screenType: ScreenType

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "Track a new activity 🌿")
            NavigationStackView(navigationStack: navigationStack) {
				AppScreen(screenType) {
					VStack(alignment: .leading, spacing: 42) {
						VStack {
							TitleAndDescriptionView(viewModel: titleVm)
							Button(action: {
								isShowingSettings = true
							}, label: {
								LinkImageView()
							})
						}

						TileWallView(viewModel: activitiesTileWallViewModel, selectedString: $selectedActivity, selectedUnderlyingValue: $selectedActivity)

						// Pushing Views (Navigation)
						PushView(destination: PeopleInHouseScreen(router: HouseSettingsRouter(navStack: navigationStack)), destinationId: NavigationIds.settingsViewId, isActive: $goToNextScreen, label: { EmptyView() })
						PushView(destination: SettingsView(navigationStack: navigationStack), destinationId: NavigationIds.settingsViewId, isActive: $isShowingSettings) { EmptyView() }
					}.onChange(of: selectedActivity) { _ in
						goToNextScreen = true
					}.onAppear {
						activitiesTileWallViewModel.tiles = trackingCategories
					}
				}
            }
    }

}

struct TrackNewActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
		TrackNewActivityScreen(navigationStack: NavigationStack(), screenType: .fullScreenDismissable)
    }
}
