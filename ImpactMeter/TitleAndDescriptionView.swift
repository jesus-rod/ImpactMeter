//
//  InputView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 14.03.21.
//

import SwiftUI

struct TitleAndDescriptionView: View {

    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.title)
                .font(.largeTitle).bold()
                .multilineTextAlignment(.leading)
                .padding([.leading, .trailing], 24)
            Text(viewModel.description)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding([.leading, .trailing], 24)
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading)
        .animation(.easeIn)
    }
}

extension TitleAndDescriptionView {

    struct ViewModel {
        let title: String
        let description: String
    }
}

struct TitleAndDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TitleAndDescriptionView.ViewModel(title: "Where do you live right now?", description: "This is to determine the average for your region. None of your personal data will be shared.")
        TitleAndDescriptionView(viewModel: viewModel)
            .previewDevice("iPhone 11")
    }
}
