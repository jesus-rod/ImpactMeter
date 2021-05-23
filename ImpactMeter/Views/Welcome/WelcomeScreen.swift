//
//  WelcomeScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.02.21.
//

import SwiftUI

struct WelcomeScreen: View {
    let viewModel: ViewModel

    @State private var opacity = 0.0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.title)
                .font(.body)
                .padding([.horizontal], 24)
            Text(viewModel.subtitle)
                .bold()
                .font(.largeTitle)
                .padding([.horizontal], 24)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Rectangle().foregroundColor(.clear))
            .opacity(opacity)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    opacity = 1.0
                }
            }
    }
}

extension WelcomeScreen {
    struct ViewModel: Hashable {
        let idenditifer = UUID()
        let title: String
        let subtitle: String
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WelcomeScreen.ViewModel(title: "We make choices every day", subtitle: "without considering how it affects our environment.")
        WelcomeScreen(viewModel: viewModel)
    }
}
