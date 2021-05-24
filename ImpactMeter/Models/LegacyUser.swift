//
//  User.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import Combine
import Foundation

class LegacyUser: ObservableObject {
    private let defaults = UserDefaults.standard
    private let finishedOnboardingKey: String = "finishedOnboarding"
    private let finishedTrackingOnboardingKey: String = "finishedTrackingOnboarding"

	static let shared = LegacyUser()

    init() {
        print(ProcessInfo.processInfo.environment["shouldSkipOnboarding"] ?? "Fix this after MVP yo")
        if ProcessInfo.processInfo.environment["shouldSkipOnboarding"] == "YES" {
            didFinishOnboarding = true
        } else {
            didFinishOnboarding = defaults.bool(forKey: finishedOnboardingKey)
        }

        if ProcessInfo.processInfo.environment["shouldSkipTrackingOnboarding"] == "YES" {
            didFinishTrackingOnboarding = true
        } else {
            didFinishTrackingOnboarding = defaults.bool(forKey: finishedTrackingOnboardingKey)
        }
    }

    @Published var didFinishOnboarding: Bool {
        didSet { defaults.set(didFinishOnboarding, forKey: finishedOnboardingKey) }
    }

    private func isValidCountry(selectedCountry: String) -> Bool {
        let allCountries: [Country] = CountriesGenerator().getCountries()
        let countryNames = allCountries.map { $0.name }
        return countryNames.contains(selectedCountry)
    }

    // Tracking Onboarding 📗🚀
    @Published var didFinishTrackingOnboarding: Bool {
        didSet { defaults.set(didFinishOnboarding, forKey: finishedTrackingOnboardingKey) }
    }

	var hasTrackedActivities: Bool {
		let activities = PersistanceController.shared.fetchActivities() ?? []
		if activities.isEmpty {
			return false
		}
		return true
	}
}
