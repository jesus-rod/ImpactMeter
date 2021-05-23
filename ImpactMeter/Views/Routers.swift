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

    func toHouseSize() {
        self.navStack.push(SizeOfPropertyScreen(router: self))
    }

    func toHouseYear() {
        self.navStack.push(YearOfPropertyScreen(router: self))
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
