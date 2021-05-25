//
//  Utility.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 09.05.21.
//

import Foundation

enum TrackingCategory: String, CaseIterable {
	case travel
	case utility

	var emoji: String {
		switch self {
		case .travel:
			return "✈️"
		case .utility:
			return "🚰"
		}
	}
}

protocol Trackable {
    var storageKey: String { get }
    var unit: String { get }
    var displayText: String { get }
    var type: TrackingCategory { get }
}

enum Utility: String, Hashable, Trackable {

    case water
    case electricity
    case gas
    case unknown

    var storageKey: String {
        return rawValue
    }

    var unit: String {
        switch self {
        case .electricity:
            return "kWh"
        case .gas:
            return "kWh"
        case .water:
            return "liters"
        default:
            return "??"
        }
    }

    var displayText: String {
        switch self {
        case .electricity:
            return "electricity"
        case .gas:
            return "gas"
        case .water:
            return "water"
        default:
            return "??"
        }
    }

    var type: TrackingCategory {
        return TrackingCategory.utility
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
        hasher.combine(self.unit)
    }
}
