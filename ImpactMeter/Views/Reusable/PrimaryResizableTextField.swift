//
//  PrimaryResizableTextField.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import SwiftUI

struct PrimarySuffixableTextView: View {
    let viewModel: ViewModel
    @Binding var currentText: String
    let keyboardType: UIKeyboardType

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.topPlaceholder)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(IMColors.gray)

            SuffixableTextField(placeholderText: viewModel.bottomPlaceholder, text: $currentText, suffixText: viewModel.stickyText)
                .frame(height: 45, alignment: .topLeading)
            Spacer()
            PrimaryButton(title: "Confirm", action: {
                print("go to structure")
            })
        }
        //            .background(Rectangle().foregroundColor(.purple))
        .padding([.horizontal], 24)
        .edgesIgnoringSafeArea(.all)
    }
}

extension PrimarySuffixableTextView {
    struct ViewModel {
        let topPlaceholder: String
        let bottomPlaceholder: String
        let stickyText: String
    }
}

struct PrimaryResizableTextView_Preview: PreviewProvider {
    static var previews: some View {
        let textViewVm = PrimarySuffixableTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country", stickyText: "sqm")
        PrimarySuffixableTextView(viewModel: textViewVm, currentText: .constant(""), keyboardType: .webSearch)
            .previewDevice("iPhone 11")
    }
}
