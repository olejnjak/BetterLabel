//
//  BetterLabelTests.swift
//  BetterLabelTests
//
//  Created by Jakub Olejník on 25/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import XCTest
import BetterLabel

final class BetterLabelTests: XCTestCase {
    private var label: BetterLabel!
    private var underlyingLabel: UILabel! {
        // we know that first subview is `BetterAttributedLabel`
        return label.subviews[0].subviews.compactMap { $0 as? UILabel }[0]
    }
    
    override func setUp() {
        super.setUp()
        
        label = BetterLabel()
        label.text = "Test"
    }
    
    // MARK: - Test

    func testFont() {
        label.font = .systemFont(ofSize: 13, weight: .bold)
        
        let font = loadAttribute(.font) as? UIFont
        XCTAssertNotNil(font)
        XCTAssertEqual(font?.pointSize, 13)
        XCTAssertTrue(font!.fontName.contains("Bold"))
    }
    
    func testTextColor() {
        label.textColor = .red
        
        let color = loadAttribute(.foregroundColor) as? UIColor
        XCTAssertEqual(color, .red)
    }
    
    func testTextAlignment() {
        label.textAlignment = .right
        
        let paragraphStyle = loadAttribute(.paragraphStyle) as? NSParagraphStyle
        XCTAssertNotNil(paragraphStyle)
        
        let alignment = paragraphStyle?.alignment
        XCTAssertEqual(alignment, .right)
    }
    
    func testLineHeight() {
        label.lineHeight = 20
        
        let paragraphStyle = loadAttribute(.paragraphStyle) as? NSParagraphStyle
        XCTAssertNotNil(paragraphStyle)
        
        let minimumLineHeight = paragraphStyle?.minimumLineHeight
        XCTAssertEqual(minimumLineHeight, 20)
        
        let maximumLineHeight = paragraphStyle?.maximumLineHeight
        XCTAssertEqual(maximumLineHeight, 20)
    }
    
    func testLineHeightReset() {
        testLineHeight()
        
        label.lineHeight = nil
        
        let paragraphStyle = loadAttribute(.paragraphStyle) as? NSParagraphStyle
        let minimumLineHeight = paragraphStyle?.minimumLineHeight
        XCTAssertEqual(minimumLineHeight, 0)
    }
    
    func testKern() {
        label.kern = 5
        
        let kern = loadAttribute(.kern) as? CGFloat
        XCTAssertEqual(kern, 5)
    }
    
    func testKernReset() {
        testKern()
        
        label.kern = nil
        
        let kern = loadAttribute(.kern) as? CGFloat
        XCTAssertNil(kern)
    }
    
    func testLineSpacing() {
        label.lineSpacing = 5
        
        let paragraphStyle = loadAttribute(.paragraphStyle) as? NSParagraphStyle
        XCTAssertNotNil(paragraphStyle)
        
        let lineSpacing = paragraphStyle?.lineSpacing
        XCTAssertEqual(lineSpacing, 5)
    }
    
    func testLineSpacingReset() {
        testLineSpacing()
        
        label.lineSpacing = nil
        
        let paragraphStyle = loadAttribute(.paragraphStyle) as? NSParagraphStyle
        let lineSpacing = paragraphStyle?.lineSpacing
        XCTAssertEqual(lineSpacing, 0)
    }
    
    func testLineBreakMode() {
        label.lineBreakMode = .byTruncatingMiddle
        label.lineSpacing = 10
        
        let paragraphStyle = loadAttribute(.paragraphStyle) as? NSParagraphStyle
        let lineBreakMode = paragraphStyle?.lineBreakMode
        XCTAssertEqual(lineBreakMode, .byTruncatingMiddle)
    }
    
    func testText() {
        label.text = "Lorem ipsum"
        let attributedText = label.attributedText
        XCTAssertEqual(attributedText.string, "Lorem ipsum")
    }
    
    @available(iOS 10.0, *)
    func testDefaultAdjustsFontForContentSizeCategoryIsFalse() {
        XCTAssertFalse(underlyingLabel.adjustsFontForContentSizeCategory)
    }
    
    @available(iOS 11.0, *)
    func testAdjustsFontForContentSizeCategory() {
        label.adjustsFontForContentSizeCategory = true
        XCTAssertTrue(underlyingLabel.adjustsFontForContentSizeCategory)
    }
    
    // MARK: - Helpers
    
    private func loadAttribute(_ attribute: NSAttributedString.Key) -> Any? {
        return label.attributedText.attribute(attribute, at: 0, effectiveRange: nil)
    }
}
