import XCTest
@testable import CanvasKit

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
final class PreviewTests: XCTestCase {
    
    func testPreviewDevicesExist() throws {
        // Test that PreviewDevice extensions are available
        let iPhone16Pro = PreviewDevice.iPhone16Pro
        let iPadPro = PreviewDevice.iPadPro11M4
        let iPhoneSE = PreviewDevice.iPhoneSE3
        
        XCTAssertEqual(iPhone16Pro.rawValue, "iPhone 16 Pro")
        XCTAssertEqual(iPadPro.rawValue, "iPad Pro 11-inch (M4)")
        XCTAssertEqual(iPhoneSE.rawValue, "iPhone SE (3rd generation)")
    }
    
    func testPreviewDeviceCollections() throws {
        // Test that device collections are properly defined
        let phones = PreviewDevices.phones
        let pads = PreviewDevices.pads
        let all = PreviewDevices.all
        
        XCTAssertFalse(phones.isEmpty)
        XCTAssertFalse(pads.isEmpty)
        XCTAssertEqual(all.count, phones.count + pads.count)
        
        // Verify specific devices are in the collections
        XCTAssertTrue(phones.contains(where: { $0.rawValue == "iPhone 16 Pro" }))
        XCTAssertTrue(pads.contains(where: { $0.rawValue == "iPad Pro 11-inch (M4)" }))
    }
    
    func testMultiDevicePreviewCreation() throws {
        // Test that MultiDevicePreview can be created without compilation errors
        let devices: [PreviewDevice] = [.iPhone16Pro, .iPadPro11M4]
        
        // This should compile without issues
        let preview = MultiDevicePreview(devices: devices) {
            Text("Test View")
        }
        
        XCTAssertEqual(preview.devices.count, 2)
        XCTAssertNil(preview.colorScheme)
    }
    
    func testMultiDevicePreviewWithColorScheme() throws {
        let devices: [PreviewDevice] = [.iPhone16Pro]
        
        let preview = MultiDevicePreview(devices: devices, colorScheme: .dark) {
            Text("Dark Mode Test")
        }
        
        XCTAssertEqual(preview.devices.count, 1)
        XCTAssertEqual(preview.colorScheme, .dark)
    }
    
    func testConveniencePreviewMethods() throws {
        let testView = Text("Test")
        
        // These should all compile without errors, indicating the methods are available
        let _ = testView.quickPreview()
        let _ = testView.phonePreview()
        let _ = testView.padPreview()
        let _ = testView.allDevicesPreview()
        let _ = testView.colorSchemePreview()
        let _ = testView.colorSchemePreview(on: .iPhone16Pro)
        let _ = testView.previewOn(devices: [.iPhone16Pro, .iPadPro11M4])
        
        // If we get here without compilation errors, the test passes
        XCTAssertTrue(true, "All convenience preview methods are available")
    }
}
#else
// If SwiftUI is not available, create a placeholder test
final class PreviewTests: XCTestCase {
    func testSwiftUINotAvailable() throws {
        // This test indicates SwiftUI is not available on this platform
        XCTAssertTrue(true, "SwiftUI not available on this platform")
    }
}
#endif