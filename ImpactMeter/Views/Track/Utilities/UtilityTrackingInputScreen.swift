//
//  UtilityTrackingInputScreen.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 24.05.21.
//

import SwiftUI

struct UtilityTrackingInputScreen: View {

	@State var utilityText: String = ""
	@State private var goToNextScreen: Bool = false
	@Environment(\.presentationMode) var presentationMode

	@State private var summaryItem: SummaryItem?

	let utility: Utility

	var body: some View {
		let titleVm = TitleAndDescriptionView.ViewModel(title: "How much \(utility.displayText) does your household consume?", description: "")
		AppScreen(.withBackButton) {
			VStack(alignment: .leading, spacing: 24) {
				TitleAndDescriptionView(viewModel: titleVm)

				let suffixTvVm = PrimarySuffixableTextField.ViewModel(topPlaceholder: "Consumption", bottomPlaceholder: "This many", stickyText: utility.unit)
				PrimarySuffixableTextField(viewModel: suffixTvVm, currentText: $utilityText, keyboardType: .phonePad)

				Spacer()

				PrimaryButton(title: "Confirm") {
					validateUtility(with: utilityText)
				}.keyboardAdaptive()
			}
		}.sheet(item: $summaryItem, onDismiss: {
			presentationMode.wrappedValue.dismiss()
		}, content: { detailInfo in
			UtilityTrackingSummaryScreen(utility: utility, item: detailInfo)
		})
	}

	private func validateUtility(with value: String) {
		storeActivity(utility: utility, storedValue: value)
		summaryItem = SummaryItem(valueToShow: value)
		goToNextScreen = true
	}

	private func storeActivity(utility: Utility, storedValue: String) {
		let amount = storedValue.components(separatedBy: " ")
		let firstPart = amount.first ?? ""
		// convert first part to Integer
		let amountIntegerValue = Int(firstPart) ?? 0
		PersistanceController.shared.addTrackedActivity(amount: amountIntegerValue, trackActivity: utility)
	}
}
