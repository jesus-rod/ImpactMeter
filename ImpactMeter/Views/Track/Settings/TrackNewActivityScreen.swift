//
//  TrackNewActivityScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 20.04.21.
//

import SwiftUI
import NavigationStack
import Collections

struct TrackNewActivityScreen: View {

    let navigationStack: NavigationStack

	@State private var selectedString: String = ""
	@State private var selectedActivity: TrackingCategory = TrackingCategory.utility
    @State private var goToNextScreen: Bool = false
    @State private var isShowingSettings: Bool = false

    // Categories hardcoded 
    private var trackingCategories: OrderedSet<TileView<TrackingCategory>.ViewModel> {
        return OrderedSet(TrackingCategory.allCases
                            .map { TileView<TrackingCategory>.ViewModel(text: $0.rawValue.capitalized,
															  emoji: $0.emoji,
															  underlyingValue: $0) })
    }

    @ObservedObject private var activitiesTileWallViewModel = TileWallView<TrackingCategory>.ViewModel(tiles: [TileView<TrackingCategory>.ViewModel]())

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

						TileWallView(viewModel: activitiesTileWallViewModel,
									 selectedString: $selectedString,
									 selectedUnderlyingValue: $selectedActivity)

						// Pushing Views (Navigation)

						PushView(destination: SettingsView(navigationStack: navigationStack), destinationId: NavigationIds.settingsViewId, isActive: $isShowingSettings) { EmptyView() }
					}.onChange(of: selectedString) { newlySelectedActivity in
						print(newlySelectedActivity)
						switch selectedActivity {
						case .travel:
							navigationStack.push(TravelTrackingScreen(), withId: NavigationIds.travelViewId)
						case .utility:
							navigationStack.push(UtilityTrackingScreen(), withId: NavigationIds.utilityViewId)
//							PushView(destination: PeopleInHouseScreen(router: HouseSettingsRouter(navStack: navigationStack)), destinationId: NavigationIds.settingsViewId, isActive: $goToNextScreen, label: { EmptyView() })
						}
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
