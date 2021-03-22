//
//  PrimaryTextView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI
import Combine

struct PrimaryTextView: View {

    @EnvironmentObject var user: User
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.topPlaceholder)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(IMColors.gray)
            TextField(viewModel.bottomPlaceholder, text: $user.country)
                .font(Font.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.primary)
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
        PrimaryTextView(viewModel: vm)
            .previewDevice("iPhone 11")
    }
}
