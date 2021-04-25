//
//  PrimaryButton.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String
    @Binding var isDisabled: Bool
    let action: (() -> Void)

    @State private var wasButtonAnimated: Bool = false

    init(title: String, isDisabled: Binding<Bool> = .constant(false), action: @escaping (() -> Void)) {
        self.title = title
        _isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.callout).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 48)
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
                .disabled(isDisabled)
        })
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "This be the title", action: {
            print("test")
        })
    }
}
