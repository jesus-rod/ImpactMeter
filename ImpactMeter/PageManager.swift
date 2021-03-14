//
//  PageManager.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 01.03.21.
//

import SwiftUI

struct PageManager<Content: View>: View {


    @Binding var currentIndex: Int
    @GestureState private var currentPage: Int = 0

    let pageCount: Int
    let content: Content

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: ()-> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.content.frame(width: geometry.size.width, height: geometry.size.height)
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .background(Rectangle().foregroundColor(.clear))
            .onTapGesture {
                let newIndex = self.currentIndex + 1
                self.currentIndex = min(max(Int(newIndex) , 0),  self.pageCount - 1)
            }
            .gesture(
                DragGesture()
                    .updating($currentPage, body: { (value, state, transaction) in
                        // Do something while updating
                        // If needed.
                    })
                    .onEnded({ (value) in
                        print("onEnded value translation \(value.translation)")
                        let translationWidth = value.translation.width
                        let geometryWidth = geometry.size.width
                        let offset = translationWidth / geometryWidth
                        print("offset \(offset)")
                        let unroundedIndex = (CGFloat(self.currentIndex) - offset)
                        print("unroundedIndex \(unroundedIndex)")
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        print("newIndex \(newIndex)")
                        self.currentIndex = min(max(Int(newIndex) , 0),  self.pageCount - 1)
                    })
            )


        }
    }
}
