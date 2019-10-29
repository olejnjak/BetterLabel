# Changelog

- please enter new entries in format 

```
- <description> (#<PR_number>, kudos to @<author>)
```

## master

- better support for dynamic type
    - introduce property `automaticallyAdjustsFontForContentSizeCategory` which registers to dynamic type notifications and applies `fontMetrics` to properties that should be affected (`lineHeight`, `lineSpacing`, `font`)
    - introduce property `fontMetrics`
- add support for SwiftPM
- make `textColor` optional as default `nil` value works better with dark mode than the old `UIColor.black` (#16, kudos to @olejnjak)