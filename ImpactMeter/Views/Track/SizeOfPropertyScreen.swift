//
//  NumberOfPeopleScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 11.04.21.
//

import SwiftUI

struct SizeOfPropertyScreen: View {
    @State private var squareMeters: String = ""
    var body: some View {
        let titleVm = TitleAndDescriptionView.ViewModel(title: "How big is the property?", description: "")
        VStack(alignment: .leading, spacing: 42) {
            TitleAndDescriptionView(viewModel: titleVm)

            let textViewVm = PrimaryTextView.ViewModel(topPlaceholder: "Size", bottomPlaceholder: "This many")
            PrimaryTextView(viewModel: textViewVm, currentText: $squareMeters, keyboardType: .numberPad, stickyText: "m²")
            Spacer()
        }
    }
}

struct NumberOfPeopleScreen_Previews: PreviewProvider {
    static var previews: some View {
        SizeOfPropertyScreen()
    }
}
