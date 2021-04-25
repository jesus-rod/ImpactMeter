//
//  KeyboardAdaptive.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 25.04.21.
//

import SwiftUI
import Combine

// https://www.vadimbulavin.com/how-to-move-swiftui-view-when-keyboard-covers-text-field/
struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 24

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer()
                content
                    .padding(.bottom, self.bottomPadding)
                    .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                        let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                        let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                        self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
                }
            }
            .animation(.easeOut(duration: 0.3))
        }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}

// From https://stackoverflow.com/a/14135456/6870041
extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }

    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}
