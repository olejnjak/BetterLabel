//
//  UIButton+BetterLabel.swift
//  BetterLabel
//
//  Created by Lukáš Hromadník on 15/06/2019.
//  Copyright © 2019 Jakub Olejník. All rights reserved.
//

import UIKit

extension UIButton {
    func setBetterLabel(_ label: BetterLabel, for state: UIControl.State) {
        setAttributedTitle(label.attributedText, for: state)
    }
}
