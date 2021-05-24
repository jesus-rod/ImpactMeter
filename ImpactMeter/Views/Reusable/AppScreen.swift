//
//  AppScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//

import SwiftUI
import NavigationStack

enum ScreenType {
	case fullScreenDismissable
	case withBackButton
	case regular
}

struct AppScreen<Content>: View where Content: View {
	private let screenType: ScreenType
    private let content: Content

	init(_ screenType: ScreenType = .regular, content: () -> Content) {
        self.screenType = screenType
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.myAppBgColour.edgesIgnoringSafeArea(.horizontal)
            content.offset(y: 40)
			switch screenType {
			case .fullScreenDismissable:
				FullScreenDismissBackButton()
			case .withBackButton:
				BackButton()
			case .regular:
				EmptyView()
			}

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

	struct FullScreenDismissBackButton: View {
		@Environment(\.presentationMode) var presentationMode

		var body: some View {
			VStack {
				HStack {
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "xmark")
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
