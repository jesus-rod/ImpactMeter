//
//  ViewDestinations.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 23.05.21.
//

import NavigationStack

struct NavigationIds {
	static let settingsViewId = "settings_push_id"
	static let travelViewId = "travel_push_id"
	static let utilityViewId = "utility_push_id"
}

class FirstTimeActivityTrackingRouter {

    private let navStack: NavigationStack

    init(navStack: NavigationStack) {
        self.navStack = navStack
    }
}

class HouseSettingsRouter {

    private let navStack: NavigationStack

    init(navStack: NavigationStack) {
        self.navStack = navStack
    }

    func toHouseSize(router: HouseSettingsRouter) {
        navStack.push(SizeOfPropertyScreen(router: router))
    }

    func toHouseYear(router: HouseSettingsRouter) {
        navStack.push(YearOfPropertyScreen(router: router))
    }

    func popBackToSettings() {
		self.navStack.pop(to: .view(withId: NavigationIds.settingsViewId))
    }
}

class CountrySettingsRouter {

    private let navStack: NavigationStack

    init(navStack: NavigationStack) {
        self.navStack = navStack
    }

	fileprivate func extractedFunc() -> CountrySummary {
		return CountrySummary(router: self)
	}

	func toCountrySummary() {
		self.navStack.push(extractedFunc())
    }

    func popBackToSettings() {
		self.navStack.pop(to: .view(withId: NavigationIds.settingsViewId))
    }
}
