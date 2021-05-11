//
//  SettingsView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 10.05.21.
//

import SwiftUI
import NavigationStack

struct SettingsView: View {

    @State private var shouldShowCountrySelection = false
    @State private var shouldShowHouseholdSelection = false

    var body: some View {
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42, content: {
                let titleVm = TitleAndDescriptionView.ViewModel(title: "Your personal settings", description: "")
                TitleAndDescriptionView(viewModel: titleVm)

                // Location
                let locationVm = SettingsSection.ViewModel(icon: "🇬🇧", title: "Current Location", text: "England", action: {
                    shouldShowCountrySelection = true
                })

                // Household
                let householdVm = SettingsSection.ViewModel(icon: "🔌", title: "Household Properties", text: "2 People, 52m", action: {
                    shouldShowCountrySelection = true
                })

                VStack(alignment: .leading, spacing: 48) {
                    SettingsSection(viewModel: locationVm)
                    SettingsSection(viewModel: householdVm)
                }

                Spacer()

                PushView(destination: CountryInputView(showBackButton: true), isActive: $shouldShowCountrySelection, label: { EmptyView() })
            })
        }
    }
}

struct SettingsSection: View {

    struct ViewModel {
        let icon: String
        let title: String
        let text: String
        let action: (() -> Void)
    }

    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(viewModel.title)
                .foregroundColor(.primary)
                .font(.subheadline)
                .bold()
            Button(action: {
                viewModel.action()
            }, label: {
                VStack(spacing: 16) {
                    HStack {
                        Text(viewModel.icon)
                        Text(viewModel.text)
                            .foregroundColor(Color.primary)
                            .font(.callout)
                            .fontWeight(.medium)
                        Spacer()
                        Text("edit")
                            .foregroundColor(Color.primary)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                    }
                    Divider()
                }
            })

        }.padding(.horizontal, 24)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
