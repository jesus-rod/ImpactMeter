//
//  TileView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileView: View {

    let viewModel: ViewModel

    @State var isActive: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(viewModel.text)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(isActive ? .white : .black)
            Text(viewModel.emoji)
        }.padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 8)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(isActive ? .blue : IMColors.blueishGray))
        .onTapGesture(perform: {
            isActive.toggle()
        })
    }
}

extension TileView {

    struct ViewModel: Hashable {
        let id = UUID()
        let text: String
        let emoji: String
    }


}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TileView.ViewModel(text: "Netherlands", emoji: "🇳🇱")
        TileView(viewModel: vm, isActive: false)
    }
}
