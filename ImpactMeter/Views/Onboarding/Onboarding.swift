//
//  Onboarding.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var user: User

    var body: some View {
        if user.shouldShowCountrySummary {
            CountrySummary()
        } else {
            CountryInputView()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
