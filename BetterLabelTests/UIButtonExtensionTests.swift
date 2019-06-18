//
//  UIButtonExtensionTests.swift
//  BetterLabelTests
//
//  Created by Lukáš Hromadník on 18/06/2019.
//  Copyright © 2019 Jakub Olejník. All rights reserved.
//

import XCTest
@testable import BetterLabel

final class UIButtonExtensionTests: XCTestCase {
    func testCallability() {
        let label = BetterLabel()
        let button = UIButton()
        button.setBetterLabel(label, for: .normal)
    }
    
    
}
