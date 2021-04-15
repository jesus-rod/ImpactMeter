//
//  PrimaryTextView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import Combine
import Introspect
import SwiftUI

struct PrimaryTextView: View {
    let viewModel: ViewModel
    @Binding var currentText: String
    private let keyboardType: UIKeyboardType
    private let stickyText: String

    init(viewModel: ViewModel, currentText: Binding<String>, keyboardType: UIKeyboardType = .webSearch, stickyText: String = "") {
        self.viewModel = viewModel
        _currentText = currentText
        self.keyboardType = keyboardType
        self.stickyText = stickyText
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.topPlaceholder)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(IMColors.gray)
            HStack(spacing: 8) {
                TextField(viewModel.bottomPlaceholder, text: $currentText) { _ in
                    print("new text is", $currentText)
                } onCommit: {
                    print("done tapped")

                }.font(Font.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(.primary)
                    .keyboardType(keyboardType)
                    .introspectTextField { textfield in
                        textfield.becomeFirstResponder()
                        textfield.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                    }
            }
        }.frame(maxWidth: .infinity,
                maxHeight: .none,
                alignment: .leading)
            .padding([.leading, .trailing], 24)
    }
}

extension PrimaryTextView {
    struct ViewModel {
        let topPlaceholder: String
        let bottomPlaceholder: String
    }
}

struct PrimaryTextView_Previews: PreviewProvider {
    static var previews: some View {
        let textViewVm = PrimaryTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country")
        PrimaryTextView(viewModel: textViewVm, currentText: .constant(""), stickyText: "x")
            .previewDevice("iPhone 11")
    }
}
