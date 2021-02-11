import XCTest

import UIImageExtensionsTests

var tests = [XCTestCaseEntry]()
tests += UIImageToPixelBufferTests.allTests()
tests += UIImageToSampleBufferTests.allTests()
tests += UIImagesToVideoTests.allTests()
XCTMain(tests)
