//
//  SettingsView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 10.05.21.
//

import SwiftUI
import NavigationStack

struct SettingsView: View {

	@State private var shouldShowCountrySelection = false
	@State private var shouldShowHouseholdSelection = false

	let navigationStack: NavigationStack

	@ObservedObject var user = PersistanceController.shared.fetchUser()

	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		AppScreen(.withBackButton) {
			VStack(alignment: .leading, spacing: 42, content: {
				let titleVm = TitleAndDescriptionView.ViewModel(title: "Your personal settings", description: "")
				TitleAndDescriptionView(viewModel: titleVm)

				// Location
				// User country

				let userCountry = CountriesGenerator().countryName(for: user.country ?? "US") ?? "--"
				let userFlag = CountriesGenerator().countryFlag(for: user.country ?? "US")
				let locationVm = SettingsSection.ViewModel(icon: userFlag, title: "Current Location", text: userCountry, action: {
					shouldShowCountrySelection = true
				})

				// Household
				let userHouseSize = user.propertySize
				let userPeepsInHouse = user.peepsInHouse
				let peopleOrPersonText = userPeepsInHouse > 1 ? "People" : "Person"
				let houseHoldText = "\(userPeepsInHouse) \(peopleOrPersonText), \(userHouseSize) sqm"

				let householdVm = SettingsSection.ViewModel(icon: "🔌", title: "Household Properties", text: houseHoldText, action: {
					shouldShowHouseholdSelection = true
				})

				VStack(alignment: .leading, spacing: 48) {
					SettingsSection(viewModel: locationVm)
					SettingsSection(viewModel: householdVm)
				}

				Spacer()

				PushView(destination: CountryInputView(router: CountrySettingsRouter(navStack: navigationStack)),
						 isActive: $shouldShowCountrySelection,
						 label: { EmptyView() })
				PushView(destination: PeopleInHouseScreen(router: HouseSettingsRouter(navStack: navigationStack)),
						 isActive: $shouldShowHouseholdSelection, label: { EmptyView() })
			})
		}.onAppear {

		}.edgesIgnoringSafeArea([.bottom, .horizontal])

	}
}

struct SettingsSection: View {

	struct ViewModel {
		let icon: String
		let title: String
		let text: String
		let action: (() -> Void)
	}

	let viewModel: ViewModel

	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			Text(viewModel.title)
				.foregroundColor(.primary)
				.font(.subheadline)
				.bold()
			Button(action: {
				viewModel.action()
			}, label: {
				VStack(spacing: 16) {
					HStack {
						Text(viewModel.icon)
						Text(viewModel.text)
							.foregroundColor(Color.primary)
							.font(.callout)
							.fontWeight(.medium)
						Spacer()
						Text("edit")
							.foregroundColor(Color.primary)
							.font(.subheadline)
							.fontWeight(.semibold)

					}
					Divider()
				}
			})

		}.padding(.horizontal, 24)
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView(navigationStack: NavigationStack())
	}
}
