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
    private let finishedTrackingOnboardingKey: String = "finishedTrackingOnboarding"

    init() {
        print("are we skipping ONBOARDING?")
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
        }
    }

    @Published var peopleInHouse: String = "" {
        didSet {
            print("Selected # of people")
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


    // Tracking Onboarding 📗🚀
    @Published var didFinishTrackingOnboarding: Bool {
        didSet { defaults.set(didFinishOnboarding, forKey: finishedTrackingOnboardingKey) }
    }


}
