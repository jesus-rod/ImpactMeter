//
//  TileView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

struct TileView<T: Hashable>: View {

    struct ViewModel: Hashable, Equatable {
        let identifier = UUID()
        let text: String
        let emoji: String
        let underlyingValue: T

        // The UUID is recreated and therefore must be excluded from equality comparison
        static func == (lhs: Self, rhs: Self) -> Bool {
            return
                lhs.text == rhs.text &&
                lhs.emoji == rhs.emoji &&
                lhs.underlyingValue == rhs.underlyingValue
        }
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
                selectedUnderlyingValue = viewModel.underlyingValue
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
        let tileViewVm = TileView<String>.ViewModel(text: "Netherlands", emoji: "🇳🇱", underlyingValue: "Netherlands")
        TileView(viewModel: tileViewVm, selectedTag: .constant(""), isSelected: false, selectedUnderlyingValue: .constant(""))
    }
}
