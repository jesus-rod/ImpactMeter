//
//  String+Length.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 16.04.21.
//

import UIKit

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
