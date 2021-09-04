//
//  UIButton+BetterLabel.swift
//  BetterLabel
//
//  Created by Lukáš Hromadník on 15/06/2019.
//  Copyright © 2019 Jakub Olejník. All rights reserved.
//

import UIKit

extension UIButton {
    public func setBetterLabel(_ label: BetterLabel, for state: UIControl.State) {
        setAttributedTitle(label.attributedText, for: state)

        if #available(iOS 11.0, *) {
            titleLabel?.adjustsFontForContentSizeCategory = label.adjustsFontForContentSizeCategory
        }
        titleLabel?.lineBreakMode = label.lineBreakMode
        titleLabel?.isEnabled = label.isEnabled
        titleLabel?.adjustsFontSizeToFitWidth = label.adjustsFontSizeToFitWidth
        titleLabel?.allowsDefaultTighteningForTruncation = label.allowsDefaultTighteningForTruncation
        titleLabel?.baselineAdjustment = label.baselineAdjustment
        titleLabel?.minimumScaleFactor = label.minimumScaleFactor
        titleLabel?.numberOfLines = label.numberOfLines
        
        contentEdgeInsets = label.contentInset
    }
}
