//
//  IMPageControl.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 27.03.21.
//

import SwiftUI

struct IMPageControl: View {
    @Binding var currentPage: Int

    var body: some View {
        HStack {
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(currentPage == 0 ? Color.blue : Color.gray)
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(currentPage == 1 ? Color.blue : Color.gray)
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(Color.gray)
        }
    }
}

struct IMPageControl_Previews: PreviewProvider {
    static var previews: some View {
        IMPageControl(currentPage: .constant(0))
    }
}
