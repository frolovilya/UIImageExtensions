import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UIImageToPixelBufferTests.allTests),
        testCase(UIImageToSampleBufferTests.allTests),
        testCase(UIImagesToVideoTests.allTests)
    ]
}
#endif
