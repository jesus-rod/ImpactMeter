//
//  Colors.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 21.03.21.
//

import SwiftUI
import UIKit

struct IMColors {
    @Environment(\.colorScheme) var colorScheme

    static let darkGray = Color(hex: 0x9F9B9B)
    static let gray = Color(hex: 0xC5C5C5)
    static let anotherGray = Color(hex: 0xEEEEEE)
    static let blueishGray =  Color(hex: 0xF2F2F7)
    static let lightGray = Color(hex: 0xF5F5F5)
    static let superLightGray = Color(hex: 0xFCFCFC)


}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
