//
//  User.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import Combine
import Foundation

class User: ObservableObject {


    private let defaults = UserDefaults.standard
    private let finishedOnboardingKey: String = "finishedOnboarding"
    private let shouldShowCountryOverviewKey: String = "shouldShowCountry"

    init() {
        print("are we skipping ONBOARDING?")
        print(ProcessInfo.processInfo.environment["shouldSkipOnboarding"] ?? "Fix this after MVP yo")
        if ProcessInfo.processInfo.environment["shouldSkipOnboarding"] == "YES" {
            self.didFinishOnboarding = false
        } else {
            self.didFinishOnboarding = defaults.bool(forKey: finishedOnboardingKey)
        }
    }


    @Published var country: String = "" {
        didSet {
            // Check for validity
            guard isValidCountry(selectedCountry: country) else {
                print("Show alert to user for not valid country")
                return
            }
            // Save user country to user/defaults
            print("Valid country selected, lets save it")
            shouldShowCountrySummary = true
            // Finish onboarding and set variable
        }
    }

    @Published var didFinishOnboarding: Bool {
        didSet { defaults.set(didFinishOnboarding, forKey: finishedOnboardingKey) }
    }

    @Published var shouldShowCountrySummary: Bool = false

    private func isValidCountry(selectedCountry: String) -> Bool {
        let allCountries: [Country] = CountriesGenerator().getCountries()
        let countryNames = allCountries.map { $0.name }
        return countryNames.contains(selectedCountry)
    }
}
