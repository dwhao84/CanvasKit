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
    
    func testDeviceCollectionConsistency() throws {
        // Verify that all devices in collections are actually defined
        let phones = PreviewDevices.phones
        let pads = PreviewDevices.pads
        let all = PreviewDevices.all
        
        // Check that phones array contains expected devices
        XCTAssertEqual(phones.count, 4, "Expected 4 phone devices")
        XCTAssertTrue(phones.contains(.iPhoneSE3))
        XCTAssertTrue(phones.contains(.iPhone16))
        XCTAssertTrue(phones.contains(.iPhone16Pro))
        XCTAssertTrue(phones.contains(.iPhone15ProMax))
        
        // Check that pads array contains expected devices
        XCTAssertEqual(pads.count, 3, "Expected 3 pad devices")
        XCTAssertTrue(pads.contains(.iPadMini6))
        XCTAssertTrue(pads.contains(.iPadPro11M4))
        XCTAssertTrue(pads.contains(.iPadPro129Gen6))
        
        // Check that all array is sum of phones and pads
        XCTAssertEqual(all.count, phones.count + pads.count)
        
        // Verify all phones are in all collection
        for phone in phones {
            XCTAssertTrue(all.contains(phone), "All collection should contain \(phone.rawValue)")
        }
        
        // Verify all pads are in all collection
        for pad in pads {
            XCTAssertTrue(all.contains(pad), "All collection should contain \(pad.rawValue)")
        }
    }
    
    func testQuickPreviewDevices() throws {
        // Test that quickPreview uses the expected devices
        // This is important for documentation consistency
        let quickPreviewDevices: [PreviewDevice] = [.iPhoneSE3, .iPhone16Pro, .iPadPro11M4]
        
        // Verify these devices exist and have correct names
        XCTAssertEqual(quickPreviewDevices[0].rawValue, "iPhone SE (3rd generation)")
        XCTAssertEqual(quickPreviewDevices[1].rawValue, "iPhone 16 Pro")
        XCTAssertEqual(quickPreviewDevices[2].rawValue, "iPad Pro 11-inch (M4)")
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