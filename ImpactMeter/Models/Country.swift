//
//  Country.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import Foundation

struct Country {
    let name: String
    let flag: String
}

struct CountriesGenerator {
    func getCountries() -> [Country] {
        var countries: [Country] = []

        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id)
            guard let countryName = name else { continue }
            countries.append(Country(name: countryName, flag: emojiFlag(for: code)))
        }

        return countries
    }

    private func emojiFlag(for countryCode: String) -> String {
        let base: UInt32 = 127_397
        var s = ""
        for v in countryCode.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
}
