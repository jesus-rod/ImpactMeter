//
//  ContentView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.02.21.
//

import SwiftUI

struct StartupCoordinator: View {
    private let animationDuration = 1.0
    @State private var titleOpacity = 0.0
    @State private var isShowingSplash: Bool = true
    @State private var onboardingStarted = false
    @EnvironmentObject var user: User

    var body: some View {
        VStack(alignment: .leading) {
            if isShowingSplash {
                VStack(alignment: .leading) {
                    Text("Impact")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .opacity(titleOpacity)
                        .onAppear {
                            titleOpacity = 1.0
                        }
                    Text("Meter")
                        .bold()
                        .font(.largeTitle)
                        .frame(alignment: .leading)
                        .opacity(titleOpacity)
                }
                .padding([.leading, .trailing], 24)
            } else if user.didFinishOnboarding {
                MainTabView()
            } else if !isShowingSplash && !onboardingStarted {
                WelcomingWords(letsGoButtonTapped: $onboardingStarted)
            } else if onboardingStarted {
                Onboarding()
            } else {
                fatalError("we fked up")
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                switchToWelcomeScreens()
            }
    }

    private func switchToWelcomeScreens() {
        let deadline: DispatchTime = .now() + animationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeInOut(duration: 0.7)) {
                self.isShowingSplash = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartupCoordinator()
    }
}
