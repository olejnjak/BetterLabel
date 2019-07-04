//
//  LabelStyling.swift
//  BetterLabel
//
//  Created by Jakub Olejník on 25/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit

internal protocol LabelStyling {
    var adjustsFontSizeToFitWidth: Bool { get }
    var allowsDefaultTighteningForTruncation: Bool { get }
    var baselineAdjustment: UIBaselineAdjustment { get }
    var contentInset: UIEdgeInsets { get }
    var isEnabled: Bool { get }
    var isUserInteractionEnabled: Bool { get }
    var lineBreakMode: NSLineBreakMode { get }
    var minimumScaleFactor: CGFloat { get }
    var numberOfLines: Int { get }
    var text: String { get }
}
