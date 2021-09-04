//
//  BetterAttributedLabel.swift
//  BetterLabel
//
//  Created by Jakub Olejník on 25/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit

open class BetterAttributedLabel: UIView {
    open var text = "" {
        didSet { updateAttributedString() }
    }
    
    open var attributes = [NSAttributedString.Key: Any]() {
        didSet { updateAttributedString() }
    }
    
    open var contentInset = UIEdgeInsets.zero {
        didSet { updateLayout() }
    }

    open override var backgroundColor: UIColor? {
        get { super.backgroundColor }
        set {
            super.backgroundColor = newValue
            label.backgroundColor = newValue
        }
    }

    open override var forFirstBaselineLayout: UIView { label }
    
    open override var forLastBaselineLayout: UIView { label }
    
    internal weak var label: UILabel!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        leadingConstraint = label.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingConstraint.priority = UILayoutPriority(rawValue: 999)
        trailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor)
        trailingConstraint.priority = UILayoutPriority(rawValue: 999)
        topConstraint = label.topAnchor.constraint(equalTo: topAnchor)
        topConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomConstraint = label.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
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
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let textSize = label.sizeThatFits(size)
        return CGSize(
            width: textSize.width + contentInset.left + contentInset.right,
            height: textSize.height + contentInset.top + contentInset.bottom
        )
    }
    
    // MARK: Private helpers
    
    private func updateAttributedString() {
        label.attributedText = attributedText
    }
    
    private func updateLayout() {
        leadingConstraint.constant = contentInset.left
        trailingConstraint.constant = -contentInset.right
        topConstraint.constant = contentInset.top
        bottomConstraint.constant = -contentInset.bottom
        layoutIfNeeded()
    }
}

extension BetterAttributedLabel: LabelStyling {
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
}

extension BetterAttributedLabel {
    open var attributedText: NSAttributedString { NSAttributedString(string: text, attributes: attributes) }
}
