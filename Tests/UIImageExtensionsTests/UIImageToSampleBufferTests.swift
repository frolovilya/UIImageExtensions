import XCTest
#if os(OSX)
import AppKit
#else
import UIKit
#endif
import CoreMedia
@testable import UIImageExtensions

final class UIImageToSampleBufferTests: XCTestCase {
    
    func testIncorrectInput() {
        let image = PlatformImage.fromBase64String(TestImageData.tennisBall)
        XCTAssertNotNil(image)
        
        XCTAssertNil(image!.toSampleBuffer(frameIndex: -1))
        XCTAssertNil(image!.toSampleBuffer(framesPerSecond: 0))
        XCTAssertNil(image!.toSampleBuffer(framesPerSecond: -1))
    }

    private func imageToBufferSampleTimingInfo(frameIndex: Int,
                                               framesPerSecond: Double) -> CMSampleTimingInfo {
        let image = PlatformImage.fromBase64String(TestImageData.tennisBall)
        XCTAssertNotNil(image)
        
        let buffer = image!.toSampleBuffer(frameIndex: frameIndex,
                                           framesPerSecond: framesPerSecond)
        XCTAssertNotNil(buffer)

        return try! buffer!.sampleTimingInfo(at: .zero)
    }
    
    private func testTimingInfo(_ timingInfo: CMSampleTimingInfo,
                                presentationTimeStampSeconds: Double,
                                durationSeconds: Double,
                                decodeTimeStamp: CMTime = CMTime.invalid) -> Void {
        XCTAssertEqual(timingInfo.presentationTimeStamp.seconds, presentationTimeStampSeconds)
        XCTAssertEqual(timingInfo.duration.seconds, durationSeconds)
        XCTAssertEqual(timingInfo.decodeTimeStamp, decodeTimeStamp)
    }
    
    func testTimingInfo24FPS() {
        // first sample
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 0, framesPerSecond: 24),
                       presentationTimeStampSeconds: 0,
                       durationSeconds: 1/24.0)

        // less than FPS
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 15, framesPerSecond: 24),
                       presentationTimeStampSeconds: 15/24.0,
                       durationSeconds: 1/24.0)

        // more than FPS
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 43, framesPerSecond: 24),
                       presentationTimeStampSeconds: 43/24.0,
                       durationSeconds: 1/24.0)

        // high sample index
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 1000, framesPerSecond: 24),
                       presentationTimeStampSeconds: 1000/24.0,
                       durationSeconds: 1/24.0)
    }
    
    func testTimingInfoSlowFPS() {
        // first sample
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 0, framesPerSecond: 0.5),
                       presentationTimeStampSeconds: 0,
                       durationSeconds: 1/0.5)
        
        // some low sample index
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 11, framesPerSecond: 0.5),
                       presentationTimeStampSeconds: 11/0.5,
                       durationSeconds: 1/0.5)
        
        // some high sample index
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 5555, framesPerSecond: 0.5),
                       presentationTimeStampSeconds: 5555/0.5,
                       durationSeconds: 1/0.5)
    }
    
    func testTimingInfoFastFPS() {
        // first sample
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 0, framesPerSecond: 600),
                       presentationTimeStampSeconds: 0,
                       durationSeconds: 1/600.0)
        
        // less than FPS
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 331, framesPerSecond: 600),
                       presentationTimeStampSeconds: 331/600.0,
                       durationSeconds: 1/600.0)
        
        // more than fps
        testTimingInfo(imageToBufferSampleTimingInfo(frameIndex: 9099, framesPerSecond: 600),
                       presentationTimeStampSeconds: 9099/600.0,
                       durationSeconds: 1/600.0)
    }

    static var allTests = [
        ("testIncorrectInput", testIncorrectInput),
        ("testTimingInfo24FPS", testTimingInfo24FPS),
        ("testTimingInfoSlowFPS", testTimingInfoSlowFPS),
        ("testTimingInfoFastFPS", testTimingInfoFastFPS)
    ]
}
