//
//  AppScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//

import SwiftUI
import NavigationStack

struct AppScreen<Content>: View where Content: View {
    private let showBackButton: Bool
    private let content: Content

    init(showBackButton: Bool = false, content: () -> Content) {
        self.showBackButton = showBackButton
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.myAppBgColour.edgesIgnoringSafeArea(.horizontal)
            content.offset(y: 40)
            if showBackButton { BackButton() }
        }
    }

    struct BackButton: View {
        var body: some View {
            VStack {
                HStack {
                    PopView {
                        Image(systemName: "arrow.backward")
                            .modifier(NavigationLinkStyle())
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct NavigationLinkStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 20, weight: Font.Weight.semibold, design: .default))
            .padding()
            .foregroundColor(Color.primary)
    }
}

extension Color {
    static let myAppBgColour = Color.clear
}
