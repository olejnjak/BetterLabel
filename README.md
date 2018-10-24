# BetterLabel
BetterLabel simplifies setting general styling properties which should normally be handled by `NSAttributedString`.

## Motivation

On iOS is setting some `UILabel` properties very inconvenient as they can't be set directly on `UILabel` - so we need to use `NSAttributedString`. Let's see an example.

Imagine you should create label with custom _font_, _text color_, _alignment_,  _letter spacing_ (_kern_) and custom _line height_. Well then you should create an `NSAttributedString` and set it to the label.

```swift
let text = "Some text"
let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.minimumLineHeight = 15
paragraphStyle.maximumLineHeight = 15
paragraphStyle.alignment = .center
let textAttr = NSAttributedString(string: text, attributes: [
    .font: UIFont.systemFont(ofSize: 10),
    .foregroundColor: UIColor.blue,
    .kern: 1.2,
    .paragraphStyle: paragraphStyle
])
someLabel.attributedText = textAttr
```

And usually you just have a label which should keep all the styling and you just want to change the text. Well with `NSAttributedString` you have store the attributes somewhere and it all becomes so complicated. 😬

What you want is to set the style of the label and then later just set the text it should display! And that's where `BetterLabel` becomes very useful. 

Just define the style:

```swift
betterLabel.font = UIFont.systemFont(ofSize: 10)
betterLabel.textColor = .blue
betterLabel.kern = 1.2
betterLabel.lineHeight = 15
betterLabel.textAlignment = .center
```

And whenever you like, you just set the text you want to display!

```swift
betterLabel.text = "Some text"
```

Simple right? 😎

And imagine that you need some padding inside the label...well you might think about embedding the label in some container view or about subclassing the label. That's not necessary with `BetterLabel` (as it is better than `UILabel` 😎). Just set the insets!

```swift
betterLabel.contentInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 12)
```

That's nice right? 😃

## Attributed label

Well `BetterLabel` itself has shortcuts for the most commonly used properties from `NSAttributedString`, but that might not be enought for your case. That's why `BetterAttributedLabel` exists. You just set the `attributes` property and later on the text and you're good to go.

```swift
betterAttributedLabel.attributes = [
    .font: .systemFont(ofSize: 10),
    .foregroundColor: UIColor.red
]
betterAttributedLabel.text = "That's how it's done with BetterAttributedLabel 😎"
```

That should be all that is needed 🙂

## What is not a good use case

If you need to display one string with different styles, that's not the purpose of `BetterLabel` and you should use common `UILabel`. The reason for this is that I think that combining `String` and `NSAttributedString` into single label component is a bit confusing.
