# Triangulation
[![Version](https://img.shields.io/cocoapods/v/Triangulation.svg?style=flat)](http://cocoapods.org/pods/Triangulation)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/younatics/Triangulation/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Triangulation.svg?style=flat)](http://cocoapods.org/pods/Triangulation)
[![Swift 4.0](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)

## Introduction
📐 Triangulate your image! `Triangulation` will magically change your image like this!

| Before | After |
| :----------: | :-----------------------: |
| ![Before](https://github.com/younatics/Triangulation/blob/master/image/before.png) | ![After](https://github.com/younatics/Triangulation/blob/master/image/after.png) |


## Requirements

`Triangulation` is written in Swift 4.2. Compatible with iOS 9.0+

## Installation

### Cocoapods

Triangulation is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Triangulation'
```
### Carthage
```
github "younatics/Triangulation"
```

## Usage

Add `TriangulationView` with custom cell size. That's it!
```swift
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
