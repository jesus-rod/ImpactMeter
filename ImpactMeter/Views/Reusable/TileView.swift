//
//  TileView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileView<T: Hashable>: View {

    struct ViewModel: Hashable {
        let identifier = UUID()
        let text: String
        let emoji: String
        let underylingValue: T
    }

    let viewModel: ViewModel
    @Binding var selectedTag: String
    @State var isSelected: Bool
    @Binding var selectedUnderlyingValue: T

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

                print("Selected", viewModel.text)
                selectedTag = viewModel.text
                selectedUnderlyingValue = viewModel.underylingValue
                isSelected = selectedTag == viewModel.text
                print("is it Active? \(isSelected)")
            })
    }

    private func deselectTag() {
        selectedTag = ""
        isSelected = false
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        let tileViewVm = TileView<String>.ViewModel(text: "Netherlands", emoji: "🇳🇱", underylingValue: "Netherlands")
        TileView(viewModel: tileViewVm, selectedTag: .constant(""), isSelected: false, selectedUnderlyingValue: .constant(""))
    }
}
