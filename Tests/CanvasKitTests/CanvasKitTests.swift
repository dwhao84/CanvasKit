import XCTest
@testable import CanvasKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI
#endif

final class CanvasKitTests: XCTestCase {
    
    // Test that the module can be imported without errors
    func testModuleImport() throws {
        // This test passes if the module imports successfully
        XCTAssertTrue(true, "CanvasKit module imported successfully")
    }
    
    #if canImport(SwiftUI) && DEBUG
    
    // MARK: - PreviewDevice Extension Tests
    
    func testPreviewDeviceExtensionExists() throws {
        // Test that our custom PreviewDevice extensions are available
        let device = PreviewDevice.iPhone16Pro
        XCTAssertEqual(device.rawValue, "iPhone 16 Pro")
    }
    
    func testiPhoneDevices() throws {
        // Test iPhone device definitions
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
    
    func testiPadDevices() throws {
        // Test iPad device definitions
        XCTAssertEqual(PreviewDevice.iPadPro129Gen6.rawValue, "iPad Pro 12.9-inch (6th generation)")
        XCTAssertEqual(PreviewDevice.iPadPro11M4.rawValue, "iPad Pro 11-inch (M4)")
        XCTAssertEqual(PreviewDevice.iPadMini6.rawValue, "iPad mini (6th generation)")
        XCTAssertEqual(PreviewDevice.iPadAir5.rawValue, "iPad Air (5th generation)")
        XCTAssertEqual(PreviewDevice.iPad10Gen.rawValue, "iPad (10th generation)")
    }
    
    func testAppleWatchDevices() throws {
        // Test Apple Watch device definitions
        XCTAssertEqual(PreviewDevice.appleWatchUltra2.rawValue, "Apple Watch Ultra 2 (49mm)")
        XCTAssertEqual(PreviewDevice.appleWatchSeries9_45.rawValue, "Apple Watch Series 9 (45mm)")
    }
    
    func testMacDevices() throws {
        // Test Mac device definitions
        XCTAssertEqual(PreviewDevice.macStudio.rawValue, "Mac Studio")
    }
    
    // MARK: - PreviewDevices Enum Tests
    
    func testPreviewDevicesPhones() throws {
        // Test phones array contains expected devices
        let phones = PreviewDevices.phones
        XCTAssertEqual(phones.count, 4)
        XCTAssertTrue(phones.contains { $0.rawValue == "iPhone SE (3rd generation)" })
        XCTAssertTrue(phones.contains { $0.rawValue == "iPhone 16" })
        XCTAssertTrue(phones.contains { $0.rawValue == "iPhone 16 Pro" })
        XCTAssertTrue(phones.contains { $0.rawValue == "iPhone 15 Pro Max" })
    }
    
    func testPreviewDevicesPads() throws {
        // Test pads array contains expected devices
        let pads = PreviewDevices.pads
        XCTAssertEqual(pads.count, 3)
        XCTAssertTrue(pads.contains { $0.rawValue == "iPad mini (6th generation)" })
        XCTAssertTrue(pads.contains { $0.rawValue == "iPad Pro 11-inch (M4)" })
        XCTAssertTrue(pads.contains { $0.rawValue == "iPad Pro 12.9-inch (6th generation)" })
    }
    
    func testPreviewDevicesAll() throws {
        // Test all array combines phones and pads
        let all = PreviewDevices.all
        let phones = PreviewDevices.phones
        let pads = PreviewDevices.pads
        
        XCTAssertEqual(all.count, phones.count + pads.count)
        
        // Verify all phones are included
        for phone in phones {
            XCTAssertTrue(all.contains { $0.rawValue == phone.rawValue })
        }
        
        // Verify all pads are included
        for pad in pads {
            XCTAssertTrue(all.contains { $0.rawValue == pad.rawValue })
        }
    }
    
    // MARK: - MultiDevicePreview Tests
    
    func testMultiDevicePreviewInit() throws {
        // Test MultiDevicePreview can be initialized
        let devices = [PreviewDevice.iPhone16Pro, PreviewDevice.iPadPro11M4]
        
        let preview = MultiDevicePreview(devices: devices) {
            EmptyView()
        }
        
        XCTAssertEqual(preview.devices.count, 2)
        XCTAssertEqual(preview.devices[0].rawValue, "iPhone 16 Pro")
        XCTAssertEqual(preview.devices[1].rawValue, "iPad Pro 11-inch (M4)")
        XCTAssertNil(preview.colorScheme)
    }
    
    func testMultiDevicePreviewInitWithColorScheme() throws {
        // Test MultiDevicePreview can be initialized with color scheme
        let devices = [PreviewDevice.iPhone16Pro]
        
        let preview = MultiDevicePreview(devices: devices, colorScheme: .dark) {
            EmptyView()
        }
        
        XCTAssertEqual(preview.devices.count, 1)
        XCTAssertEqual(preview.colorScheme, .dark)
    }
    
    func testMultiDevicePreviewInitWithDynamicTypeSize() throws {
        // Test MultiDevicePreview can be initialized with dynamic type size
        let devices = [PreviewDevice.iPhone16Pro]
        
        let preview = MultiDevicePreview(
            devices: devices, 
            colorScheme: .light, 
            dynamicTypeSize: DynamicTypeSize.large
        ) {
            EmptyView()
        }
        
        XCTAssertEqual(preview.devices.count, 1)
        XCTAssertEqual(preview.colorScheme, .light)
    }
    
    // MARK: - View Extension Tests
    
    struct TestView: View {
        var body: some View {
            Text("Test")
        }
    }
    
    func testQuickPreviewExtension() throws {
        // Test that quickPreview extension works
        let testView = TestView()
        let preview = testView.quickPreview()
        
        // We can't easily test the internal structure, but we can test that it compiles and returns a view
        XCTAssertTrue(preview is MultiDevicePreview<TestView>)
    }
    
    func testPhonePreviewExtension() throws {
        // Test that phonePreview extension works
        let testView = TestView()
        let preview = testView.phonePreview()
        
        XCTAssertTrue(preview is MultiDevicePreview<TestView>)
    }
    
    func testPadPreviewExtension() throws {
        // Test that padPreview extension works
        let testView = TestView()
        let preview = testView.padPreview()
        
        XCTAssertTrue(preview is MultiDevicePreview<TestView>)
    }
    
    func testAllDevicesPreviewExtension() throws {
        // Test that allDevicesPreview extension works
        let testView = TestView()
        let preview = testView.allDevicesPreview()
        
        XCTAssertTrue(preview is MultiDevicePreview<TestView>)
    }
    
    func testPreviewOnDevicesExtension() throws {
        // Test that previewOn(devices:) extension works
        let testView = TestView()
        let customDevices = [PreviewDevice.iPhone16, PreviewDevice.iPadMini6]
        let preview = testView.previewOn(devices: customDevices)
        
        XCTAssertTrue(preview is MultiDevicePreview<TestView>)
    }
    
    func testColorSchemePreviewExtension() throws {
        // Test that colorSchemePreview extension works
        let testView = TestView()
        let preview = testView.colorSchemePreview()
        
        // This returns a Group, so we test it compiles
        XCTAssertNotNil(preview)
    }
    
    func testColorSchemePreviewOnDeviceExtension() throws {
        // Test that colorSchemePreview(on:) extension works
        let testView = TestView()
        let preview = testView.colorSchemePreview(on: .iPadPro11M4)
        
        // This returns a Group, so we test it compiles
        XCTAssertNotNil(preview)
    }
    
    #else
    
    func testSwiftUINotAvailable() throws {
        // Test that runs when SwiftUI is not available (e.g., on Linux)
        // This verifies the conditional compilation is working correctly
        XCTAssertTrue(true, "SwiftUI features are correctly unavailable on this platform")
    }
    
    #endif
}
