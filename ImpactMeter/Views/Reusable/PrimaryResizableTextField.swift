//
//  PrimaryResizableTextField.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import SwiftUI

struct PrimarySuffixableTextField: View {
    let viewModel: ViewModel
    @Binding var currentText: String
    let keyboardType: UIKeyboardType

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.topPlaceholder)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(IMColors.gray)

            SuffixableTextField(placeholderText: viewModel.bottomPlaceholder,
                                text: $currentText,
                                suffixText: viewModel.stickyText) { (updatedText) in
                // If needed do something here with the updated text
            }
            .frame(height: 24, alignment: .topLeading)
        }
        .padding([.horizontal], 24)
        .ignoresSafeArea(SafeAreaRegions.keyboard)
    }
}

extension PrimarySuffixableTextField {
    struct ViewModel {
        let topPlaceholder: String
        let bottomPlaceholder: String
        let stickyText: String
    }
}

struct PrimaryResizableTextView_Preview: PreviewProvider {
    static var previews: some View {
        let textViewVm = PrimarySuffixableTextField.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country", stickyText: "sqm")
        PrimarySuffixableTextField(viewModel: textViewVm, currentText: .constant(""), keyboardType: .webSearch)
            .previewDevice("iPhone 11")
    }
}
