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
    let code: String
}

struct CountriesGenerator {
    func getCountries() -> [Country] {
        var countries: [Country] = []
        for code in NSLocale.isoCountryCodes as [String] {
            guard let countryName = countryName(for: code) else { continue }
            countries.append(Country(name: countryName, flag: countryFlag(for: code), code: code))
        }
        return countries
    }

    func countryName(for countryCode: String) -> String? {
        let countryId = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
        return NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: countryId)
    }

    func countryFlag(for countryCode: String) -> String {
        let base: UInt32 = 127_397
        var finalEmojiFlag = ""
        for val in countryCode.uppercased().unicodeScalars {
            finalEmojiFlag.unicodeScalars.append(UnicodeScalar(base + val.value)!)
        }
        return finalEmojiFlag
    }
}
