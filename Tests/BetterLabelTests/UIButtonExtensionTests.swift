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
    
    @available(iOS 10.0, *)
    func testDefaultAdjustsFontForContentSizeCategoryIsFalse() {
        let label = BetterLabel()
        let button = UIButton()
        button.setBetterLabel(label, for: .normal)
        XCTAssertFalse(button.titleLabel!.adjustsFontForContentSizeCategory)
    }
    
    @available(iOS 11.0, *)
    func testAdjustsFontForContentSizeCategory() {
        let label = BetterLabel()
        label.adjustsFontForContentSizeCategory = true
        let button = UIButton()
        button.setBetterLabel(label, for: .normal)
        XCTAssertTrue(button.titleLabel!.adjustsFontForContentSizeCategory)
    }
}
