//
//  CountrySummary.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI
import NavigationStack

struct CountrySummary: View {
    private let pageCount: Int = 2
    @EnvironmentObject var user: LegacyUser
    @State private var currentPage = 0
    @State private var wasButtonAnimated = false

    let router: CountrySettingsRouter

    var body: some View {
        AppScreen {
            VStack {
                PageManager(pageCount: pageCount, currentIndex: $currentPage) {
                    // Country Summary Page One
                    VStack(alignment: .center, spacing: 80) {
                        let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Footprint overview",
                                                                               description: "The CO2 emission level for the Netherlands has been on the decline since 2008.")

                        let circleOverCircleVm = CircleOverCircleView.ViewModel(circleTitle: "11.6 tons of CO2", circleSubtitle: "Dutch per capita", circleColor: Color.blue, circleUndertextTitle: "8.2 tons of CO2", circleUndertextSubTitle: "EU Average per capita")
                        CircleOverCircleView(titleViewModel: titleViewModel, viewModel: circleOverCircleVm)
                    }.isHidden(currentPage != 0)
                    .animation(.easeInOut)
                    // Country Summary Page Two
                    let titleViewModel2 = TitleAndDescriptionView.ViewModel(title: "Your emissions",
                                                                            description: "Calculating your personal footprint is done automatically and it will be compared to average levels in your area.")

                    let circleViewModel = CircleInCircleView.ViewModel(circleTitle: "Footprint", circleSubtitle: "", circleColor: Color.primary, circleUndertextTitle: "8.2 tons of CO2", circleUndertextSubTitle: "EU Average per capita")
                    CircleInCircleView(titleViewModel: titleViewModel2, viewModel: circleViewModel).isHidden(currentPage != 1)
                        .animation(.easeInOut)
                } // .background(Color.red)
                Spacer()
                // Page Control
                IMPageControl(currentPage: $currentPage)
                    .animation(.easeInOut)
                    .isHidden(wasButtonAnimated)
                if currentPage == pageCount - 1 {
                    PopView(destination: .root) {
                        PrimaryButton(title: "Got it") {
                            router.popBackToSettings()
                        }.padding(.top, 24)
                    }
                }

            }.padding([.bottom], 24)
            .animation(.easeIn)
        }.edgesIgnoringSafeArea(.top)
    }
}

struct CountrySummary_Previews: PreviewProvider {
    static var previews: some View {
        CountrySummary(router: CountrySettingsRouter(navStack: NavigationStack()))
    }
}
