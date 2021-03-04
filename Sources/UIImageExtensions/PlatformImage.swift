#if os(OSX)

import AppKit
public typealias PlatformImage = NSImage

extension PlatformImage {
    convenience init(cgImage: CGImage) {
        self.init(cgImage: cgImage,
                  size: NSSize(width: cgImage.width, height: cgImage.height))
    }
    
    var cgImage: CGImage? {
        cgImage(forProposedRect: nil, context: nil, hints: nil)
    }
    
    func pngData() -> Data? {
        guard let image = cgImage else { return nil }
        return NSBitmapImageRep(cgImage: image)
            .representation(using: .png, properties: [:])
    }
}

#else

import UIKit
public typealias PlatformImage = UIImage

#endif
