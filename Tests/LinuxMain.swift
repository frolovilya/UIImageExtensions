import XCTest

import UIImageExtensionsTests

var tests = [XCTestCaseEntry]()
tests += UIImageToPixelBufferTests.allTests()
tests += UIImageToSampleBufferTests.allTests()
XCTMain(tests)
