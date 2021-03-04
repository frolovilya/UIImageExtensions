import Foundation
#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension PlatformImage {
    /**
     Initialize `UIImage` from Base64 encoded string
     
     - Parameter base64String: Base64 encoded image data in a string presentation
     - Returns: `UIImage` instance or `nil`, if unable to initialize
     */
    public static func fromBase64String(_ base64String: String) -> PlatformImage? {
        if let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            return PlatformImage(data: data)
        } else {
            return nil
        }
    }
    
    /// Return `UIImage` PNG data as Base64 encoded string
    public var base64String: String? {
        self.pngData()?.base64EncodedString()
    }
}
