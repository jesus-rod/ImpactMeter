//
//  WelcomingWords.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI

struct WelcomingWords: View {
    @State private var currentPage = 0
    @State private var wasButtonAnimated = false
    @Binding var letsGoButtonTapped: Bool
    let viewModel = ViewModel()

    var body: some View {
        VStack {
            let screenCount = viewModel.welcomeScreenViewModels.count
            PageManager(pageCount: screenCount, currentIndex: $currentPage) {
                ForEach(viewModel.welcomeScreenViewModels.indices, id: \.self) { index in
                    WelcomeScreen(viewModel: viewModel.welcomeScreenViewModels[index])
                        .isHidden(index != currentPage)
                        .animation(.easeInOut)
                }
            }
            Spacer()
            VStack {
                IMPageControl(currentPage: $currentPage)
                    .animation(.easeInOut)
                    .isHidden(wasButtonAnimated)
                if currentPage == viewModel.welcomeScreenViewModels.count - 1 {
                    Button(action: {
                        self.letsGoButtonTapped.toggle()
                    }, label: {
                        Text("Let's Go")
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
        }
    }
}

extension WelcomingWords {
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

struct WelcomingWords_Previews: PreviewProvider {
    static var previews: some View {
        WelcomingWords(letsGoButtonTapped: .constant(false))
    }
}
