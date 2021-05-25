//
//  Travel.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 24.05.21.
//

import Foundation

enum Travel: String, Hashable, CaseIterable, Trackable {

	case car
	case airplane
	case train

	var storageKey: String {
		return rawValue
	}

	var unit: String {
		switch self {
		case .car:
			return "kWh"
		case .airplane:
			return "kWh"
		case .train:
			return "liters"
		}
	}

	var displayText: String {
		switch self {
		case .car:
			return "Car"
		case .airplane:
			return "Airplane"
		case .train:
			return "Train"
		}
	}

	var emoji: String {
		switch self {
		case .car: return "🚗"
		case .airplane: return "✈️"
		case .train: return "🚆"
		}
	}

	var type: TrackingCategory {
		return TrackingCategory.travel
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(self.rawValue)
		hasher.combine(self.unit)
	}
}
