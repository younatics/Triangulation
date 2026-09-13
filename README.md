# Triangulation
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg?style=flat)](https://github.com/younatics/Triangulation)
[![CocoaPods](https://img.shields.io/cocoapods/v/Triangulation.svg?style=flat)](https://cocoapods.org/pods/Triangulation)
[![Platform: iOS 13.0+](https://img.shields.io/badge/platform-iOS%2013.0%2B-lightgrey.svg?style=flat)](https://developer.apple.com/ios/)
[![Swift 6.0](https://img.shields.io/badge/Swift-6.0-orange.svg?style=flat)](https://www.swift.org/)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/younatics/Triangulation/blob/master/LICENSE)

## Introduction
📐 Triangulate your image! `Triangulation` will magically change your image like this!

| Before | After |
| :----------: | :-----------------------: |
| ![Before](https://github.com/younatics/Triangulation/blob/master/image/before.png) | ![After](https://github.com/younatics/Triangulation/blob/master/image/after.png) |


## Requirements

`Triangulation` is written in Swift 6.0 and requires iOS 13.0 or later. It supports Swift Package Manager and CocoaPods.

## Installation

### Swift Package Manager

In Xcode, choose **File ▸ Add Package Dependencies…** and enter:

```
https://github.com/younatics/Triangulation.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/younatics/Triangulation.git", from: "2.0.0")
]
```

### CocoaPods

Triangulation 2.0.0 is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Triangulation', '2.0.0'
```

## Usage

Add `TriangulationView` with custom cell size. That's it!
```swift
import Triangulation

let triangleView = TriangulationView(frame: view.bounds, image: image, cellSize: 40)
view.addSubview(triangleView)
```

## References
#### Please tell me or make pull request if you use this library in your application :) 

## Author
[younatics](https://twitter.com/younatics)
<a href="http://twitter.com/younatics" target="_blank"><img alt="Twitter" src="https://img.shields.io/twitter/follow/younatics.svg?style=social&label=Follow"></a>

## License
Triangulation is available under the MIT license. See the LICENSE file for more info.
