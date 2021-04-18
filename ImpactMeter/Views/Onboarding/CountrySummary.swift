//
//  CountrySummary.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI

struct CountrySummary: View {
    private let pageCount: Int = 2
    @EnvironmentObject var user: User
    @State private var currentPage = 0
    @State private var wasButtonAnimated = false

    let titleViewModel = TitleAndDescriptionView.ViewModel(title: "Footprint overview",
                                                           description: "The CO2 emission level for the Netherlands has been on the decline since 2008.")
    var body: some View {
        VStack {
            PageManager(pageCount: pageCount, currentIndex: $currentPage) {
                // Country Summary Page One
                VStack(alignment: .center, spacing: 80) {
                    TitleAndDescriptionView(viewModel: titleViewModel)
                        .padding([.top], 80)

                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 192, height: 192, alignment: .center)
                        .shadow(color: Color.blue.opacity(0.56), radius: 24, x: 0, y: 12)
                        .background(
                            Circle()
                                .foregroundColor(IMColors.blueishGray)
                                .frame(width: 160, height: 160, alignment: .center)
                                .offset(x: 0, y: 64))
                        .overlay(
                            VStack {
                                Text("11.6 tons of CO2")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                                Text("Dutch per capita")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                        )

                    VStack(alignment: .center, spacing: 0, content: {
                        Text("8.2 tons of CO2")
                            .font(.subheadline)
                            .bold()
                        Text("EU Average per capita")
                            .font(.subheadline)
                    })

                }.isHidden(currentPage != 0)
                    .animation(.easeInOut)
                // Country Summary Page Two
                let titleViewModel2 = TitleAndDescriptionView.ViewModel(title: "Your emissions",
                                                                        description: "Calculating your personal footprint is done automatically and it will be compared to average levels in your area.")

                let circleViewModel = CircleInCircleView.ViewModel(circleTitle: "Footprint", circleSubtitle: "", circleColor: Color.primary, circleUndertextTitle: "8.2 tons of CO2", circleUndertextSubTitle: "EU Average per capita")
                CircleInCircleView(titleViewModel: titleViewModel2, viewModel: circleViewModel).isHidden(currentPage != 1)
                    .animation(.easeInOut)
            }
            Spacer()
            IMPageControl(currentPage: $currentPage)
                .animation(.easeInOut)
                .isHidden(wasButtonAnimated)
            if currentPage == pageCount - 1 {
                Button(action: {
                    user.didFinishOnboarding = true
                }, label: {
                    Text("Got it")
                        .font(.callout).bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                        .padding([.leading, .trailing], 24)
                        .onAppear(perform: {
                            wasButtonAnimated.toggle()
                        })
                        .onDisappear(perform: {
                            wasButtonAnimated.toggle()
                        })
                        .animation(.easeInOut)
                        .offset(x: 0, y: wasButtonAnimated ? 0 : 150)
                })
            }

        }.padding([.bottom], 24)
            .animation(.easeIn)
    }
}

struct CountrySummary_Previews: PreviewProvider {
    static var previews: some View {
        CountrySummary()
    }
}
