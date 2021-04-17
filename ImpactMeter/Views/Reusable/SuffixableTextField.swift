//
//  ResizableTextField.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import SwiftUI

// A textfield that supports a suffix that the user can't edit

class ModifiedTextField: UITextField {

    let placeholderLength: Int

    init(placeholderLength: Int) {
        self.placeholderLength = placeholderLength
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }

}

struct SuffixableTextField: UIViewRepresentable {

    let placeholderText: String
    @Binding var text: String
    let suffixText: String

    private let usedFont: UIFont = UIFont.boldSystemFont(ofSize: 24)

    init(placeholderText: String, text: Binding<String>, suffixText: String) {
        self.placeholderText = placeholderText
        self._text = text
        self.suffixText = " \(suffixText)"
    }

    func makeUIView(context: UIViewRepresentableContext<SuffixableTextField>) -> UITextField {
        let textField = ModifiedTextField(placeholderLength: 3)

        textField.font = usedFont
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.text = placeholderText
        textField.textColor = .placeholderText
        textField.allowsEditingTextAttributes = false

        let attributedString = NSMutableAttributedString(string: placeholderText)

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.lightGray,
                                      range: NSRange(location: 0, length: attributedString.length))

        let suffix = NSMutableAttributedString(string: suffixText)
        suffix.addAttribute(NSAttributedString.Key.foregroundColor,
                            value: UIColor.black,
                            range: NSRange(location: 0, length: suffix.length))

        attributedString.append(suffix)

        textField.attributedText = attributedString

//        textField.becomeFirstResponder()

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<SuffixableTextField>) {

        if text != "" || uiView.textColor == .label {
            uiView.text = text
            uiView.textColor = .label
        }

        uiView.delegate = context.coordinator
    }

    func makeCoordinator() -> SuffixableTextField.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SuffixableTextField

        init(_ parent: SuffixableTextField) {
            self.parent = parent
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {

            if textField.text == "This many\(parent.suffixText)" {

                // Delete the placeholder text and keep the suffix only
                textField.text = self.parent.suffixText

                // Set cursor at the beginning
                // Does not seem to work without dispatching to main
                DispatchQueue.main.async {
                    let startPosition: UITextPosition = textField.beginningOfDocument
                    textField.selectedTextRange = textField.textRange(from: startPosition, to: startPosition)
                }
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) { }

        /// Allow a maximum length of 5 for property size
        /// Allow numbers only
        /// dont allow to change the last part (sticky text at the end)
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            print("range Location \(range.location)")
            print("range Length \(range.length)")
            let maximumLength: Int = 7
            let placeholderLength: Int = parent.suffixText.count

            // This makes the new text black.
            textField.typingAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

            // should never be optional ... add some logging here
            guard let typedTextLength = textField.text?.count else {
                assertionFailure("This should never happen!")
                return false
            }

            // dont allow editing if max length reached
            let isDeletingCharacter = string == ""
            if typedTextLength >= maximumLength && !isDeletingCharacter {
                return false
            }

            // Only allow typing at the beginning (aka not where our suffix is)
            let boundOffset = isDeletingCharacter ? 0 : 1
            let upperBoundAllowedTyping = typedTextLength - placeholderLength + boundOffset
            let allowedRange: Range = 0..<upperBoundAllowedTyping

            guard allowedRange.contains(range.location) else {
                return false
            }

            // Allow decimal digits only
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
    }
}
