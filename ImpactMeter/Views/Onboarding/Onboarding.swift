//
//  Onboarding.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI
import NavigationStack

struct Onboarding: View {

    var body: some View {
        // this will break ⬇️ fix using a NavigationStackView
        CountryInputView(router: CountrySettingsRouter(navStack: NavigationStack()))
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
