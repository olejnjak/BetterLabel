//
//  BetterLabel.swift
//  BetterLabel
//
//  Created by Jakub Olejník on 23/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit

open class BetterLabel: UIView {
    open var font = UIFont.preferredFont(forTextStyle: .body) {
        didSet {
            updateAttributedString()
        }
    }
    
    open var textColor = UIColor.black {
        didSet {
            updateAttributedString()
        }
    }
    
    open var textAlignment = NSTextAlignment.natural {
        didSet { updateAttributedString() }
    }
    
    
    open var lineHeight: CGFloat? = nil {
        didSet { updateAttributedString() }
    }
    
    open var kern: CGFloat? = nil {
        didSet { updateAttributedString() }
    }
    
    open var lineSpacing: CGFloat? = nil {
        didSet { updateAttributedString() }
    }
    
    open override var forFirstBaselineLayout: UIView {
        return label.forFirstBaselineLayout
    }
    
    open override var forLastBaselineLayout: UIView {
        return label.forLastBaselineLayout
    }
    
    internal weak var label: BetterAttributedLabel!
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        
        let label = BetterAttributedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        self.label = label
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View override
    
    open override func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        super.setContentCompressionResistancePriority(priority, for: axis)
        label.setContentCompressionResistancePriority(priority, for: axis)
    }
    
    open override func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        super.setContentHuggingPriority(priority, for: axis)
        label.setContentHuggingPriority(priority, for: axis)
    }
    
    // MARK: Private helpers
    
    private func updateAttributedString() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = label.lineBreakMode
        
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        if let kern = kern {
            attributes[.kern] = kern
        }
        
        label.attributes = attributes
    }
}

extension BetterLabel: LabelStyling {
    @available(iOS 10.0, *)
    open var adjustsFontForContentSizeCategory: Bool {
        get { return label.adjustsFontForContentSizeCategory }
        set { label.adjustsFontForContentSizeCategory = newValue }
    }
    
    open var lineBreakMode: NSLineBreakMode {
        get { return label.lineBreakMode }
        set {
            label.lineBreakMode = newValue
            updateAttributedString()
        }
    }
    
    open var isEnabled: Bool {
        get { return label.isEnabled }
        set { label.isEnabled = newValue }
    }
    
    open var adjustsFontSizeToFitWidth: Bool {
        get { return label.adjustsFontSizeToFitWidth }
        set { label.adjustsFontSizeToFitWidth = newValue }
    }
    
    open var allowsDefaultTighteningForTruncation: Bool {
        get { return label.allowsDefaultTighteningForTruncation }
        set { label.allowsDefaultTighteningForTruncation = newValue }
    }
    
    open var baselineAdjustment: UIBaselineAdjustment {
        get { return label.baselineAdjustment }
        set { label.baselineAdjustment = newValue }
    }
    
    open var minimumScaleFactor: CGFloat {
        get { return label.minimumScaleFactor }
        set { label.minimumScaleFactor = newValue }
    }
    
    open var numberOfLines: Int {
        get { return label.numberOfLines }
        set { label.numberOfLines = newValue }
    }
    
    open var text: String {
        get { return label.text }
        set { label.text = newValue }
    }
    
    open var contentInset: UIEdgeInsets {
        get { return label.contentInset }
        set { label.contentInset = newValue }
    }
}

extension BetterLabel {
    open var attributedText: NSAttributedString {
        return label.attributedText
    }
}
