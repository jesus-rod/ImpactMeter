//
//  ViewDestinations.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 23.05.21.
//

import NavigationStack

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
        self.navStack.pop(to: .root)
    }
}

class CountrySettingsRouter {

    private let navStack: NavigationStack

    init(navStack: NavigationStack) {
        self.navStack = navStack
    }

    func toCountrySummary() {
        self.navStack.push(CountrySummary(router: self))
    }

    func popBackToSettings() {
        self.navStack.pop(to: .root)
    }
}
