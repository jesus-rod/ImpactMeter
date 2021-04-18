//
//  NumberOfPeopleScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import SwiftUI

struct SizeOfPropertyScreen: View {
    @State var squareMeters: String = ""
    @State private var goToNextScreen: Bool = false

    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How big is the property?", description: "")
        VStack(alignment: .leading, spacing: 42) {
            TitleAndDescriptionView(viewModel: titleVm)
            let textViewVm = PrimarySuffixableTextView.ViewModel(topPlaceholder: "Size", bottomPlaceholder: "This many", stickyText: "m²")
            PrimarySuffixableTextView(viewModel: textViewVm, currentText: $squareMeters, keyboardType: .numberPad)

            Spacer()

            PrimaryButton(title: "Confirm", action: {
                validateProperty(withSize: squareMeters)
            })
            NavigationLink(destination: YearOfPropertyScreen(),
                           isActive: $goToNextScreen,
                           label: { EmptyView() })

        }.onChange(of: squareMeters) { (value) in
            print("le val \(value)")
        }
    }

    private func validateProperty(withSize propertySize: String) {
        let meters = propertySize.components(separatedBy: " ")
        let firstPart = meters.first ?? ""
        guard firstPart.count > 0 else {
            showValidationAlert()
            return
        }

        // Go to next screen if property size is valid
        goToNextScreen = true
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
