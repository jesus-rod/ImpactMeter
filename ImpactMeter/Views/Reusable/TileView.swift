//
//  TileView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI

extension TileView: Hashable {
    static func == (lhs: TileView<T>, rhs: TileView<T>) -> Bool {
        lhs.viewModel == rhs.viewModel &&
            lhs.selectedTag == rhs.selectedTag
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(selectedTag)
        hasher.combine(selectedUnderlyingValue)
    }
}

struct TileView<T: Hashable>: View {
    let viewModel: ViewModel<T>
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

extension TileView {
    struct ViewModel<T: Hashable>: Hashable {
        static func == (lhs: TileView.ViewModel<T>, rhs: TileView.ViewModel<T>) -> Bool {
            lhs.id == rhs.id
        }

        let id = UUID()
        let text: String
        let emoji: String
        let underylingValue: T

//        init(text: String, emoji: String, underylingValue: T) {
//            self.text = text
//            self.emoji = emoji
//            self.underylingValue = T.self
//        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TileView<String>.ViewModel(text: "Netherlands", emoji: "🇳🇱", underylingValue: "Netherlands")
        TileView(viewModel: vm, selectedTag: .constant(""), isSelected: false, selectedUnderlyingValue: .constant(""))
    }
}
