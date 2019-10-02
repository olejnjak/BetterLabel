//
//  BetterLabel.swift
//  BetterLabel
//
//  Created by Jakub Olejník on 23/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit

open class BetterLabel: UIView {
    private enum AssociatedKeys {
        static var fontMetrics = UInt8(0)
        static var automaticallyAdjustsFontForContentSizeCategory = UInt8(1)
    }
    
    open var font = UIFont.preferredFont(forTextStyle: .body) {
        didSet {
            updateAttributedString()
        }
    }
    
    @available(iOS 11.0, *)
    open var fontMetrics: UIFontMetrics? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.fontMetrics) as? UIFontMetrics }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fontMetrics, newValue, .OBJC_ASSOCIATION_RETAIN)
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
    
    @available(iOS 11.0, *)
    open var automaticallyAdjustsFontForContentSizeCategory: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.automaticallyAdjustsFontForContentSizeCategory) as? Bool ?? false }
        set {
            guard automaticallyAdjustsFontForContentSizeCategory != newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.automaticallyAdjustsFontForContentSizeCategory, newValue, .OBJC_ASSOCIATION_RETAIN)
            
            // triggers `updateAttributedString()` so we do not need to call it explicitly
            adjustsFontForContentSizeCategory = newValue
            
            if newValue {
                observeContentSizeCategoryChange()
            } else {
                stopObservingContentSizeCategoryChange()
            }
        }
    }
    
    internal weak var label: BetterAttributedLabel!
    
    private let notificationCenter: NotificationCenter
    
    // MARK: Initializers
    
    public init(frame: CGRect = .zero, notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
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
    
    deinit {
        stopObservingContentSizeCategoryChange()
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
            paragraphStyle.minimumLineHeight = scale(value: lineHeight)
            paragraphStyle.maximumLineHeight = scale(value: lineHeight)
        }
        
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = scale(value: lineSpacing)
        }
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: scale(font: font),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        if let kern = kern {
            attributes[.kern] = kern
        }
        
        label.attributes = attributes
    }
    
    private func scale(value: CGFloat) -> CGFloat {
        let adjustedValue: CGFloat?
        
        if #available(iOS 11.0, *) {
            adjustedValue = adjustsFontForContentSizeCategory ? fontMetrics?.scaledValue(for: value) : value
        } else {
            adjustedValue = value
        }
        
        return adjustedValue ?? value
    }
    
    private func scale(font: UIFont) -> UIFont {
        let adjustedValue: UIFont?
        
        if #available(iOS 11.0, *) {
            adjustedValue = adjustsFontForContentSizeCategory ? fontMetrics?.scaledFont(for: font) : font
        } else {
            adjustedValue = font
        }
        
        return adjustedValue ?? font
    }
    
    private func observeContentSizeCategoryChange() {
        notificationCenter.addObserver(self, selector: #selector(contentSizeCategoryChanged), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    private func stopObservingContentSizeCategoryChange() {
        notificationCenter.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc
    private func contentSizeCategoryChanged() {
        updateAttributedString()
    }
}

extension BetterLabel: LabelStyling {
    @available(iOS 11.0, *)
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
