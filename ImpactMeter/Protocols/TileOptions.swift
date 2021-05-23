//
//  TileOptions.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 23.05.21.
//

import Foundation

protocol TileOptions: CaseIterable {
    var displayText: String { get }
    var emoji: String { get }
}
