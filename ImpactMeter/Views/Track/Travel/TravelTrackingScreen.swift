//
//  TravelTrackingScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 24.05.21.
//
import SwiftUI
import NavigationStack
import Collections

struct TravelTrackingScreen: View {

	@State private var selectedUtility = Travel.car.rawValue
	@State private var goToNextScreen: Bool = false
	@State private var selectedTravelToStore = Travel.car

	private var options: OrderedSet<TileView<Travel>.ViewModel> {
		return OrderedSet(Travel.allCases
							.map { TileView<Travel>.ViewModel(text: $0.displayText, emoji: $0.emoji, underlyingValue: $0) })
	}

	@ObservedObject private var travelTileWallViewModel = TileWallView<Travel>.ViewModel(tiles: [TileView<Travel>.ViewModel]())

	var body: some View {
		let titleVm = TitleAndDescriptionView.ViewModel(title: "Which utility would you like to track?", description: "")
		AppScreen(.withBackButton) {
			VStack(alignment: .leading, spacing: 42) {
				TitleAndDescriptionView(viewModel: titleVm)

				TileWallView(viewModel: travelTileWallViewModel,
							 selectedString: $selectedUtility,
							 selectedUnderlyingValue: $selectedTravelToStore)

//				PushView(destination: UtilityTrackingView(utility: selectedTravelToStore), isActive: $goToNextScreen, label: { EmptyView() })
			}.onChange(of: selectedTravelToStore) { _ in
				goToNextScreen = true
			}.onAppear {
				travelTileWallViewModel.tiles = options
			}
		}
	}
}
