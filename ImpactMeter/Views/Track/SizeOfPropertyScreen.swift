//
//  NumberOfPeopleScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import SwiftUI
import NavigationStack
import Combine

struct SizeOfPropertyScreen: View {
    @State var squareMeters: String = ""
    @State private var goToNextScreen: Bool = false
    @State private var isPrimaryButtonEnabled: Bool = false

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How big is the property?", description: "")
        AppScreen(showBackButton: true) {
            VStack(alignment: .leading, spacing: 42) {
                TitleAndDescriptionView(viewModel: titleVm)
                let textViewVm = PrimarySuffixableTextField.ViewModel(topPlaceholder: "Size", bottomPlaceholder: "This many", stickyText: "m²")
                PrimarySuffixableTextField(viewModel: textViewVm, currentText: $squareMeters, keyboardType: .numberPad)

                Spacer()
                PushView(destination: YearOfPropertyScreen(),
                               isActive: $goToNextScreen,
                               label: { Spacer() })

                PrimaryButton(title: "Confirm", isDisabled: $isPrimaryButtonEnabled, action: {
                    validateProperty(withSize: squareMeters)
                })
//                .padding(.bottom, 0)
                .keyboardAdaptive()
            }.onChange(of: squareMeters) { (value) in
                print("le val \(value)")
                updatePrimaryButtonState(withSize: value)
            }
        }
    }

    private func isInputValid(propertySize: String) -> Bool {
        let meters = propertySize.components(separatedBy: " ")
        let firstPart = meters.first ?? ""
        guard firstPart.count > 0 else {
            return false
        }
        return true
    }

    private func updatePrimaryButtonState(withSize propertySize: String) {
        isPrimaryButtonEnabled = isInputValid(propertySize: propertySize)
    }

    private func validateProperty(withSize propertySize: String) {
        // Go to next screen if property size is valid
        if isInputValid(propertySize: propertySize) {
            goToNextScreen = true
            return
        }

        showValidationAlert()
    }

    private func showValidationAlert() {
        print("show validation alert")
    }
}

struct NumberOfPeopleScreen_Previews: PreviewProvider {
    static var previews: some View {
        SizeOfPropertyScreen()
    }
}
