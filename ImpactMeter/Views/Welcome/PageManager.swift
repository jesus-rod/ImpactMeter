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

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        _currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.content.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onChanged { _ in
                        }
                        .onEnded { gesture in
                            let translationWidth = gesture.translation.width

                            if translationWidth > 20 {
                                // move to left
                                let newIndex = self.currentIndex - 1
                                self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                            } else if translationWidth < -20 {
                                // move to right
                                let newIndex = self.currentIndex + 1
                                self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                            }
                        }
                )
        }
    }
}
