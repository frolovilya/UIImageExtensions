# UIImageExtensions

Collection of `UIImage` utility methods to ease integration with media frameworks.

* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
  * [Core Video pixel buffer](#cvPixelBuffer)
  * [Core Media sample buffer](#cmSampleBuffer)
  * [UIImage from Base64 encoded string](#base64)

<a name="requirements"/>

## Requirements
* iOS 13.0, macOS 10.15
* Swift 5.2

<a name="installation"/>

## Installation
Use Xcode's built-in Swift Package Manager:

* Open Xcode
* Click File -> Swift Packages -> Add Package Dependency
* Paste package repository https://github.com/frolovilya/UIImageExtensions.git and press return
* Configure dependency version settings
* Import module to any file using `import UIImageExtensions`

<a name="usage"/>

## Usage
```swift
import UIKit
import UIImageExcensions

// obtain some UIImage instance
let myImage: UIImage = #imageLiteral(resourceName: "MyImage")
```

<a name="cvPixelBuffer"/>

### Core Video pixel buffer

Copies image data to `CVPixelBuffer`. 

```swift
// func toPixelBuffer() -> CVPixelBuffer?

let buffer: CVPixelBuffer? = myImage.toPixelBuffer()
```

And back from `CVPixelBuffer` to `UIImage`. Provide optional `orientation` parameter to rotate image.

```swift
// func toImage(orientation: CGImagePropertyOrientation = .up) -> UIImage?

let backToImage: UIImage? = buffer?.toImage(orientation: .left)
```

<a name="cmSampleBuffer"/>

### Core Media sample buffer

Actually wraps `CVPixelBuffer` to `CMSampleBuffer` with additional sample timing information.

With provided `frameIndex` and `framesPerSecond` the following timing rules apply:
* Sample duration (seconds): `1 / framesPerSecond`
* Sample start time: `frameIndex / framesPerSecond`
Assuming that timing starts from zero.

```swift
// func toSampleBuffer(frameIndex: Int = 0, framesPerSecond: Double = 24) -> CMSampleBuffer?

let buffer: CMSampleBuffer? = myImage.toSampleBuffer(frameIndex: 1, framesPerSecond: 24)
```

<a name="base64"/>

### Create `UIImage` from Base64 encoded string

Convenience static initializer to get `UIImage` instance right from Base64 encoded string.

```swift
// static func fromBase64String(_ base64String: String) -> UIImage?

let decodedImage: UIImage? = UIImage.fromBase64String("data:image/jpeg;base64,/9j/4AAQSkZJ...")
```

And property containing Base64 string of a `UIImage` instance.

```swift
// var base64String: String?

let imageAsString: String? = myImage.base64String
```
