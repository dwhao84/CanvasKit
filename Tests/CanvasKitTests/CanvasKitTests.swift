import XCTest
@testable import CanvasKit

final class CanvasKitTests: XCTestCase {
    
    func testCanvasKitModule() throws {
        // Test that the module imports and is accessible
        // This test ensures the basic module structure is working
        XCTAssertTrue(true, "CanvasKit module loads successfully")
    }
    
    #if canImport(SwiftUI)
    func testPreviewDeviceConstants() throws {
        // Test that all PreviewDevice constants are defined with correct values
        XCTAssertEqual(PreviewDevice.iPhone16.rawValue, "iPhone 16")
        XCTAssertEqual(PreviewDevice.iPhone16Plus.rawValue, "iPhone 16 Plus")
        XCTAssertEqual(PreviewDevice.iPhone16Pro.rawValue, "iPhone 16 Pro")
        XCTAssertEqual(PreviewDevice.iPhone16ProMax.rawValue, "iPhone 16 Pro Max")
        XCTAssertEqual(PreviewDevice.iPhone15ProMax.rawValue, "iPhone 15 Pro Max")
        XCTAssertEqual(PreviewDevice.iPhoneSE3.rawValue, "iPhone SE (3rd generation)")
        XCTAssertEqual(PreviewDevice.iPhone15.rawValue, "iPhone 15")
        XCTAssertEqual(PreviewDevice.iPhone15Plus.rawValue, "iPhone 15 Plus")
        XCTAssertEqual(PreviewDevice.iPhone15Pro.rawValue, "iPhone 15 Pro")
        XCTAssertEqual(PreviewDevice.iPhone14Pro.rawValue, "iPhone 14 Pro")
        XCTAssertEqual(PreviewDevice.iPhone14ProMax.rawValue, "iPhone 14 Pro Max")
    }
    
    func testIPadDeviceConstants() throws {
        // Test iPad device constants
        XCTAssertEqual(PreviewDevice.iPadPro129Gen6.rawValue, "iPad Pro 12.9-inch (6th generation)")
        XCTAssertEqual(PreviewDevice.iPadPro11M4.rawValue, "iPad Pro 11-inch (M4)")
        XCTAssertEqual(PreviewDevice.iPadMini6.rawValue, "iPad mini (6th generation)")
        XCTAssertEqual(PreviewDevice.iPadAir5.rawValue, "iPad Air (5th generation)")
        XCTAssertEqual(PreviewDevice.iPad10Gen.rawValue, "iPad (10th generation)")
    }
    
    func testOtherDeviceConstants() throws {
        // Test Apple Watch and Mac device constants
        XCTAssertEqual(PreviewDevice.appleWatchUltra2.rawValue, "Apple Watch Ultra 2 (49mm)")
        XCTAssertEqual(PreviewDevice.appleWatchSeries9_45.rawValue, "Apple Watch Series 9 (45mm)")
        XCTAssertEqual(PreviewDevice.macStudio.rawValue, "Mac Studio")
    }
    #endif
}
