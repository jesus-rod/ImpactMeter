//
//  DashboardSummaryView.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 28.03.21.
//

import Introspect
import SwiftUI

struct DashboardSummaryView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                DashboardSummaryHeader()
                    .padding([.bottom], 30)
                    .padding([.leading, .trailing], 24)

                Text("Categories")
                    .font(.title3).bold()
                    .multilineTextAlignment(.leading)
                    .padding([.bottom], 24)
                    .padding([.leading, .trailing], 24)
                SummaryList()
                    .padding([.bottom], 16)
            }
        }
    }
}

struct SummaryList: View {
    var body: some View {
        VStack(spacing: 16) {
            Divider()
            HStack {
                Text("✈️")
                Text("Travel")
                    .font(.body)
                Spacer()
                Image(systemName: "arrow.up")
                    .foregroundColor(.white)
                    .font(Font.system(size: 15).bold())
                    .background(
                        Circle().foregroundColor(.red)
                            .frame(width: 24, height: 24, alignment: .center)
                    ).frame(maxWidth: .infinity, alignment: .trailing)
            }
            Divider()
            HStack {
                Text("🛒")
                Text("Groceries")
                    .font(.body)
                Spacer()
                Image(systemName: "arrow.down")
                    .foregroundColor(.white)
                    .font(Font.system(size: 15).bold())
                    .background(
                        Circle().foregroundColor(.green)
                            .frame(width: 24, height: 24, alignment: .center)
                    ).frame(maxWidth: .infinity, alignment: .trailing)
            }
            Divider()
            HStack {
                Text("🚰")
                Text("Utilities")
                    .font(.body)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .font(Font.system(size: 15).bold())
                    .background(
                        Circle().foregroundColor(IMColors.darkGray)
                            .frame(width: 24, height: 24, alignment: .center)
                    ).frame(maxWidth: .infinity, alignment: .trailing)
            }
            Divider()
            HStack {
                Text("🖥")
                Text("Appliances & Devices")
                    .font(.body)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .font(Font.system(size: 15).bold())
                    .background(
                        Circle().foregroundColor(IMColors.darkGray)
                            .frame(width: 24, height: 24, alignment: .center)
                    ).frame(maxWidth: .infinity, alignment: .trailing)
            }
            Divider()

        }.padding([.leading, .trailing], 24)
    }
}

struct DashboardSummaryHeader: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let bigCircleVm = CircleWithText
            .ViewModel(diameter: 208, color: .primary, textColor: colorScheme == .dark ? Color.black : Color.white,
                       topText: "Expenses", bottomText: "1,844 kg CO2", isBigCircle: true)
        let smallCircleVm = CircleWithText
            .ViewModel(diameter: 115, color: .green, textColor: Color.white, topText: "Savings", bottomText: "372 kg CO2", isBigCircle: false)

        VStack(alignment: .leading, spacing: 88) {
            Text("Your footprint is decreasing 👌")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            CircleWithText(viewModel: bigCircleVm)
                .overlay(
                    CircleWithText(viewModel: smallCircleVm)
                        .offset(x: 100, y: -80)
                ).offset(x: -30, y: 0).frame(maxWidth: .infinity, alignment: .center)
        }.padding([.top], 52)
    }
}

struct DashboardSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSummaryView()
    }
}
