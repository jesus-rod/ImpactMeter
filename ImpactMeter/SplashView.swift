//
//  ContentView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.02.21.
//

import SwiftUI

struct SplashView: View {

    let viewModel = ViewModel.init()
    private let animationDuration = 1.0

    @State private var isShowingSplash: Bool = true
    @State private var titleOpacity = 0.0
    @State private var currentPage = 0
    @State private var wasButtonAnimated = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if self.isShowingSplash {
                VStack(alignment: .leading) {
                    Text("Impact")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .opacity(titleOpacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                titleOpacity = 1.0
                            }
                        }
                    Text("Meter")
                        .bold()
                        .font(.largeTitle)
                        .frame(alignment: .leading)
                        .opacity(titleOpacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                titleOpacity = 1.0
                            }
                        }
                }.padding([.leading, .trailing], 24)
            } else {
                VStack {
                    let screenCounnt = viewModel.welcomeScreenViewModels.count
                    PageManager(pageCount: screenCounnt, currentIndex: $currentPage) {
                        ForEach(viewModel.welcomeScreenViewModels.indices, id: \.self) { index in
                            WelcomeScreen(viewModel: viewModel.welcomeScreenViewModels[index])
                                .isHidden(index != currentPage)
                                .animation(.easeInOut)
                            
                        }
                    }
                    Spacer()
                    VStack {
                        HStack{
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(currentPage==0 ? Color.blue:Color.gray)
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(currentPage==1 ? Color.blue:Color.gray)
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(Color.gray)
                        }.animation(.easeInOut)
                        .isHidden(wasButtonAnimated)
                        if currentPage == viewModel.welcomeScreenViewModels.count - 1 {
                            Button(action: {
                                print("less goo")
                            }, label: {
                                Text("Let's Go")
                                    .font(.callout).bold()
                                    .foregroundColor(.white)
                            }).frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
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
                        }

                    }.padding([.bottom], 24)
                }

            }

        }.frame(maxWidth: .infinity, minHeight: 250, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
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

extension SplashView {

    struct ViewModel {
        let welcomeScreenViewModels: [WelcomeScreen.ViewModel]

        init() {
            let welcomeVmOne = WelcomeScreen.ViewModel(title: "We make choices every day", subtitle: "without considering how it affects our environment.")
            let welcomeVmTwo = WelcomeScreen.ViewModel(title: "In order to change, we must start by", subtitle: "visualising the impact of our behaviour,big and small.")
            let welcomeVmThree = WelcomeScreen.ViewModel(title: "This will help raise awareness and educate", subtitle: "to make conscious and impactful decisions.")
            welcomeScreenViewModels = [welcomeVmOne, welcomeVmTwo, welcomeVmThree]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

extension View {

    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
