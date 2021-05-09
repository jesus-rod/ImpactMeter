//
//  ResizableTextField.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import SwiftUI

class ModifiedTextField: UITextField {

    let placeholderLength: Int

    init(placeholderLength: Int) {
        self.placeholderLength = placeholderLength
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }

}

// A textfield that supports a suffix that the user can't edit
struct SuffixableTextField: UIViewRepresentable {

    private let maximumLength = 12
    let placeholderText: String
    @Binding var text: String {
        didSet {
            print("binding text var is: \(text)")
        }
    }
    let suffixText: String
    let modifiedTf = UITextField()
    let onEditingChanged: (String) -> Void

    private let usedFont: UIFont = UIFont.boldSystemFont(ofSize: 24)

    init(placeholderText: String,
         text: Binding<String>,
         suffixText: String,
         onEditingChanged: @escaping (String) -> Void = { _ in }) {
        self.placeholderText = placeholderText
        self._text = text
        self.suffixText = " \(suffixText)"
        self.onEditingChanged = onEditingChanged
    }

    func makeUIView(context: UIViewRepresentableContext<SuffixableTextField>) -> UITextField {

        modifiedTf.addTarget(self, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)

        modifiedTf.font = usedFont
        modifiedTf.keyboardType = UIKeyboardType.phonePad
        modifiedTf.text = placeholderText
        modifiedTf.textColor = .placeholderText
        modifiedTf.allowsEditingTextAttributes = false

        let attributedString = NSMutableAttributedString(string: placeholderText)

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.lightGray,
                                      range: NSRange(location: 0, length: attributedString.length))

        let suffix = NSMutableAttributedString(string: suffixText)
        suffix.addAttribute(NSAttributedString.Key.foregroundColor,
                            value: UIColor.label,
                            range: NSRange(location: 0, length: suffix.length))

        attributedString.append(suffix)

        modifiedTf.attributedText = attributedString
        modifiedTf.delegate = context.coordinator

        return modifiedTf
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<SuffixableTextField>) {}

    func makeCoordinator() -> SuffixableTextField.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SuffixableTextField

        init(_ parent: SuffixableTextField) {
            self.parent = parent
            super.init()
            parent.modifiedTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            let updatedValue = textField.text ?? ""
            parent.text = updatedValue
            self.parent.onEditingChanged(updatedValue)
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

        func textFieldDidEndEditing(_ textField: UITextField) {}

        /// Allow a maximum length of 5 for property size
        /// Allow numbers only
        /// dont allow to change the last part (sticky text at the end)
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let maximumLength: Int = parent.maximumLength
            let placeholderLength: Int = parent.suffixText.count

            // This makes the new text black.
            textField.typingAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

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
