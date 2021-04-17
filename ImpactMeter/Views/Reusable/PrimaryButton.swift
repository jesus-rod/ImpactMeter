//
//  PrimaryButton.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import SwiftUI

struct PrimaryButton: View {

    @State private var wasButtonAnimated: Bool = false
    let title: String
    let action:  (() -> Void)

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.callout).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
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
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "This be the title", action: {
            print("test")
        })
    }
}
