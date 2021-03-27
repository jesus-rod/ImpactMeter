//
//  PrimaryTextView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI
import Combine
import Introspect

struct PrimaryTextView: View {

    let viewModel: ViewModel
    @Binding var currentText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.topPlaceholder)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(IMColors.gray)
            TextField(viewModel.bottomPlaceholder, text: $currentText) { (changed) in
                print("new text is", $currentText)
            } onCommit: {
                print("done tapped")
                // Go to the next screen
            }.font(Font.system(size: 24, weight: .bold, design: .default))
            .foregroundColor(.primary)
            .keyboardType(.webSearch)
            .introspectTextField { (textfield) in
                textfield.becomeFirstResponder()
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
        let vm = PrimaryTextView.ViewModel(topPlaceholder: "Your location", bottomPlaceholder: "Country")
        PrimaryTextView(viewModel: vm, currentText: .constant(""))
            .previewDevice("iPhone 11")
    }
}
