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
    @State private var shouldShowValidationAlert: Bool = false

    // Object Context
    @Environment(\.managedObjectContext) var moc
    // Fetch our user
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>

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
                .keyboardAdaptive()
            }.onChange(of: squareMeters) { (    value) in
                print("le val \(value)")
            }.onAppear {
                print("# of Users found \(users.count)")
                print("Check if user has stored size of property")

                if let previousResponse = users.first?.peepsInHouse {
                    // User has already chosen how many people live in their house
                    // Should skip this screen
                    print("He previously chose \(previousResponse)")
//                    skipThisScreen()
                } else {
                    // User has not chosen how many people live in their house
                    print("Not found (peepsInHouse)")
                }

            }
            .alert(isPresented: $shouldShowValidationAlert) { () -> Alert in
                Alert(title: Text("Invalid size, try again"))
            }

        }
    }

    private func isInputValid(propertySize: String) -> (isValid: Bool, integerValue: Int) {
        // Getting something like 72 m2
        // So we get the first part eg: 72
        let meters = propertySize.components(separatedBy: " ")
        let firstPart = meters.first ?? ""
        // convert first part to Integer
        let integerValue = Int(firstPart) ?? 0

        if integerValue > 0 && firstPart.count > 0 {
            return (true, integerValue)
        }

        return (false, 0)
    }

    private func updatePrimaryButtonState(withSize propertySize: String) {
        isPrimaryButtonEnabled = isInputValid(propertySize: propertySize).isValid
    }

    private func validateProperty(withSize propertySize: String) {
        // Go to next screen if property size is valid
        let input = isInputValid(propertySize: propertySize)
        if input.isValid {
            saveSizeOfProperty(input.integerValue, completion: {
                skipThisScreen()
            })
            return
        }
        showValidationAlert()
    }

    private func showValidationAlert() {
        shouldShowValidationAlert = true

    }

    private func skipThisScreen() {
        goToNextScreen = true
    }

    private func saveSizeOfProperty(_ size: Int, completion: @escaping () -> Void) {
        let user = PersistanceController.shared.fetchUser()
        user.propertySize = Int64(size)
        PersistanceController.shared.save { error in
            if let err = error {
                print("there was an error saving size of property \(err.localizedDescription)")
                return
            }
            completion()
        }
    }
}

struct NumberOfPeopleScreen_Previews: PreviewProvider {
    static var previews: some View {
        SizeOfPropertyScreen()
    }
}
