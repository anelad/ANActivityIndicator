ANActivityIndicator
============
![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 12.0+](https://img.shields.io/badge/iOS-10.0%2B-blue.svg)
![Swift 5.0+](https://img.shields.io/badge/Swift-4.0%2B-blue.svg)
[![Version](https://img.shields.io/cocoapods/v/ANActivityIndicator.svg)](http://cocoapods.org/pods/ANActivityIndicator)
![carthage](https://img.shields.io/badge/Carthage-notCompatible-red.svg)


ANActivityIndicator is pre-built indicator animations library, based on [DGActivityIndicatorView](https://github.com/gontovnik/DGActivityIndicatorView) by [gotnovik](https://github.com/gontovnik) and [GTMActivityIndicatorView](https://github.com/GTMYang/GTMActivityIndicatorView) by [GTMYang](https://github.com/GTMYang) inspired from [loaders.css](https://github.com/ConnorAtherton/loaders.css) by [CONNOR ATHERTON](https://connoratherton.com).

## Why did I create ANActivityIndicator in a seperate repo?

First of all, I don't mean to get all the credits on this project. I did not do anything worthy comparing gotnovik's & GTMYang's works.

So why did I created ANActivityIndicator in a seperate repo?

It looks like gotnovik is not updating his repo and GTMYang's repo focuses on a bit different usage approach comparing mine.

## General Differences

### between DGActivityIndicatorView
- Implemented with Swift

### between GTMActivityIndicatorView
- Implemented with Swift 5
- Ready to use pre-built indicator animations. With GTMActivityIndicatorView, you have to add animations into your project manually.

## Added Features
- Custom animations structure (a struct like [NSNotification.Name](https://developer.apple.com/documentation/foundation/nsnotification.name)).
- Custom loading message margin.

# Demo
Check [Pre-Built Animation Types](#pre-built-animation-types) section to see animations' type.

![demo-gif](https://user-images.githubusercontent.com/5767654/34675823-d101708e-f49b-11e7-9b65-94c1a844ba3d.gif)
# Requirements
- Swift 5
- iOS 12.0 or higher

# Installation

## CocoaPods

```ruby
pod 'ANActivityIndicator'
```

## Manually
1. Download the [repo](https://github.com/anelad/ANActivityIndicator/archive/master.zip).

### As Framework
2. Copy `ANActivityIndicator` and `Source` folders into your workspace directory.
3. Add `[workspace directory]/ANActivityIndicator/ANActivityIndicator.xcodeproj` into your "workspace".
4. In `Project settings -> General` add `ANActivityIndicator.framework` to `Embedded Binaries` & `Linked Framework and Libraries`

### As SubProject
2. Copy `ANActivityIndicator` and `Source` folders into your project directory.
3. Add `ANActivityIndicator/ANActivityIndicator.xcodeproj` into your "project".

### As Code
2. Copy `ANActivityIndicator` and `Source` folders into your workspace / project directory.
3. Add contents of `[workspace / project directory]/Source` folder into your workspace / project.

# Usage

## Import
If you installed as framework or subproject; first
```swift
import ANActivityIndicator
```

## Initialization
### As view
```swift
let indicator = ANActivityIndicatorView.init(
        frame: CGrect,
        animationType: ANAnimationIndicatorType,
        color: UIColor,
        padding: CGFloat)

aView.addSubview(indicator)
```
 ### For initialization as fullscreen; refer to [Show / Hide Indicator -> As Full-Screen](#as-full-screen) section.

## Show / Hide Indicator
You have to ways to show ANActivityIndicator

### As view
```swift
let indicator = ANActivityIndicatorView.init(...)

indicator.startAnimating()

indicator.stopAnimating()
```


### As Full-Screen
You can show full-screen indicator in every class.

#### In UIViewController or its subclasses
```swift
//default
showIndicator()

hideIndicator()
```
```swift
//custom
showIndicator(
        CGSize,
        message: String,
        messageFont: UIFont,
        messageTopMargin: CGFloat,
        animationType: ANActivityIndicatorAnimationType,
        color: UIColor,
        padding: CGFloat,
        displayTimeThreshold: TimeIntervalInNanoseconds,
        minimumDisplayTime: TimeIntervalInNanoseconds)

hideIndicator()
```

#### In every class
```swift
//default
ANActivityIndicatorPresenter.shared.showIndicator()

ANActivityIndicatorPresenter.shared.hideIndicator()
```
```swift
//custom
ANActivityIndicatorPresenter.shared.showIndicator(
        CGSize,
        message: String,
        messageFont: UIFont,
        messageTopMargin: CGFloat,
        animationType: ANActivityIndicatorAnimationType,
        color: UIColor,
        padding: CGFloat,
        displayTimeThreshold: TimeIntervalInNanoseconds,
        minimumDisplayTime: TimeIntervalInNanoseconds)

ANActivityIndicatorPresenter.shared.hideIndicator()
```

## Pre-Built Animation Types

Here are the list of pre-built animations. You can see their look in [Demo](#demo) section. (Ordered with numbers)

1. .audioEqualizer
2. .ballBeat
3. .ballClipRotate
4. .ballClipRotateMultiple
5. .ballClipRotatePulse
6. .ballGridBeat
7. .ballGridPulse
8. .ballPulse
9. .ballPulseRise
10. .ballPulseSync
11. .ballRotate
12. .ballRotateChase
13. .ballScale
14. .ballScaleMultiple
15. .ballScaleRipple
16. .ballScaleRippleMultiple
17. .ballSpinFadeLoader
18. .ballTrianglePath
19. .ballZigZag
20. .ballZigZagDeflect
21. .blank
22. .cubeTransition
23. .lineScale
24. .lineScaleParty
25. .lineScalePulseOut
26. .lineScalePulseOutRapid
27. .lineSpinFadeLoader
28. .orbit
29. .pacman
30. .semiCircleSpin
31. .squareSpin
32. .triangleSkewSpin

## Custom Animations

ANActivityIndicator has a custom animation structure like `NSNotification.Name`.

 -  First create a class inherits from `ANActivityIndicatorAnimation` protocol:
 ```swift
class CustomIndicatorAnimation : ANActivityIndicatorAnimation{
        required init() { }

        func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
                ......
                //implement your animation
                //to learn how to implement, check example project or source codes.
                .....
        }
}
 ```

 - Then add `ANActivityIndicatorAnimationType` for your custom animation:

```swift
extension ANActivityIndicatorAnimationType{
        public static let customIndicatorAnimation = ANActivityIndicatorAnimationType.init(animation: CustomIndicatorAnimation.self)
}
```

- Now you can call your custom animation via its type:
```swift
ANActivityIndicatorAnimationType.customIndicatorAnimation
```

# Defaults

- Animation type: 
```swift
ANActivityIndicatorAnimationType.ballSpinFadeLoader
```
- Color of indicator:
```swift
UIColor.white
```
- Padding of indicator:
```swift
CGFloat = 0
```
- Message:
```swift
String = ""
```
- Message font:
```swift
UIFont.boldSystemFont(ofSize: 20)
```
- Message margin to indicator:
```swift
CGFloat = 8
```

- Display time threshold:
>Default time that has to be elapsed (between calls of startAnimating() and stopAnimating()) in order to actually display UI blocker. It should be set thinking about what the minimum duration of an activity is to be worth showing it to the user. If the activity ends before this time threshold, then it will not be displayed at all.
```swift
CGFloat = 0
```
- Minimum display time:
>Default minimum display time of UI blocker. Its main purpose is to avoid flashes showing and hiding it so fast. For instance, setting it to 200ms will force UI blocker to be shown for at least this time (regardless of calling stopAnimating() ealier).
```swift
CGFloat = 0
```
- Fullscreen indiator default size:
```swift
CGSize.init(width: 60, height: 60)
```
# License
This project is under MIT License. Check [LICENSE](https://github.com/anelad/ANActivityIndicator/LICENSE) file.

# Contribute
I'm very welcome any contributions. Please read the [CONTRIBUTING](https://github.com/anelad/ANActivityIndicator/CONTRIBUTING.md) file.

- Be sure you fulfill the `pull request template`.
- Be sure your code passes TravisCI. (Not implemented yet.)

# Issues
Please fulfill `issue template` before posting.

# Authors
- Base project created by [gotnovik](https://github.com/gontovnik).
- Swift version implemented by [GTMYang](https://github.com/GTMYang).
- Project inspired from [CONNOR ATHERTON](https://connoratherton.com)'s [project](https://github.com/ConnorAtherton/loaders.css).

#### ANActivityIndicator implemented by

Arda Oğul Üçpınar.
