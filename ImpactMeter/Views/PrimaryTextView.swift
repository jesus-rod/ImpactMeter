//
//  PrimaryTextView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct PrimaryTextView: View {

    @State private var textFieldData = ""
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.topPlaceholder)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(IMColors.gray)
            TextField(viewModel.bottomPlaceholder, text: $textFieldData)
                .font(Font.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.black)
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
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
        PrimaryTextView(viewModel: vm)
            .previewDevice("iPhone 11")
    }
}
