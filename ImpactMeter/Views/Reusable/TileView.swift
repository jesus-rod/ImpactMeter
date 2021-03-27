//
//  TileView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileView: View {

    let viewModel: ViewModel
    @Binding var selectedTag: String
    @State var isSelected: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(viewModel.text)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .white : .black)
            Text(viewModel.emoji)
        }.padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 8)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(isSelected ? .blue : IMColors.blueishGray))
        .onTapGesture(perform: {

            // Deselect Tag
            if isSelected {
                deselectTag()
                return
            }

            // 
            print("Selected", viewModel.text)
            // Update "selectedTag binding to inform TileWall what is selected"
            selectedTag = viewModel.text
            isSelected = selectedTag == viewModel.text
            print("is it Active? \(isSelected)")
        })
    }

    private func deselectTag() {
        selectedTag = ""
        isSelected = false
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
        TileView(viewModel: vm, selectedTag: .constant(""), isSelected: false)
    }
}
