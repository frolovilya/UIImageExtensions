import XCTest
import UIKit
@testable import UIImageExtensions

final class UIImageToPixelBufferTests: XCTestCase {
    
    func testConversionResult() {
        let image = UIImage.fromBase64String(TestImageData.tennisBall)
        XCTAssertNotNil(image)
        
        let pixelBuffer = image?.toPixelBuffer()
        XCTAssertNotNil(pixelBuffer)
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        print(image!.size.width, image!.size.height)
        XCTAssertEqual(CVPixelBufferGetWidth(pixelBuffer!), Int(image!.size.width))
        XCTAssertEqual(CVPixelBufferGetHeight(pixelBuffer!), Int(image!.size.height))
        XCTAssertEqual(CVPixelBufferGetPixelFormatType(pixelBuffer!), kCVPixelFormatType_32BGRA)
        
        /*
         QA1829:
         There are differences in the hardware alignment requirements between the various hardware platforms.
         The CVPixelBufferGetBytesPerRow function will correctly report the buffer alignment (stride) being used by the particular hardware.
         */
        XCTAssertTrue(CVPixelBufferGetBytesPerRow(pixelBuffer!) >= Int(image!.size.width * 4))
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
    }

    static var allTests = [
        ("testConversionResult", testConversionResult)
    ]
}
