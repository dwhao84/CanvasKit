//
//  File.swift
//  CanvasKit
//
//  Created by Da Wei Hao on 2025/8/15.
//

// MARK: - MultiDevicePreview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension View {
    @ViewBuilder func withColorScheme(_ scheme: ColorScheme?) -> some View {
        if let scheme { self.environment(\.colorScheme, scheme) } else { self }
    }

    /// Apply DynamicTypeSize if provided, simplified since package requires iOS 15+/macOS 12+
    @ViewBuilder func withDynamicTypeSizeIfAvailable(_ size: Any?) -> some View {
        if let s = size as? DynamicTypeSize {
            self.dynamicTypeSize(s)
        } else {
            self
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct MultiDevicePreview<Content: View>: View {
    public let devices: [PreviewDevice]
    public let colorScheme: ColorScheme?
    private let _dynamicTypeSize: Any?   // Use Any? to avoid signature limitations on older platforms
    public let content: () -> Content

    public init(
        devices: [PreviewDevice],
        colorScheme: ColorScheme? = nil,
        dynamicTypeSize: Any? = nil,     // Caller can pass DynamicTypeSize on supported platforms
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.devices = devices
        self.colorScheme = colorScheme
        self._dynamicTypeSize = dynamicTypeSize
        self.content = content
    }

    public var body: some View {
        ForEach(devices, id: \.rawValue) { device in
            content()
                .withColorScheme(colorScheme)
                .withDynamicTypeSizeIfAvailable(_dynamicTypeSize)
                .previewDevice(device)
                .previewDisplayName(device.rawValue)
        }
    }
}

// MARK: - Quick Preview Extensions

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension View {
    
    /// Quick preview - common devices (iPhone, iPad)
    func quickPreview() -> some View {
        MultiDevicePreview(devices: [.iPhoneSE3, .iPhone16Pro, .iPadPro11M4]) {
            self
        }
    }
    
    /// Quick preview - iPhone 16 Pro
    func phonePreview() -> some View {
        MultiDevicePreview(devices: [.iPhone16Pro]) {
            self
        }
    }
    
    /// Quick preview - iPad Pro 11" M4
    func padPreview() -> some View {
        MultiDevicePreview(devices: [.iPadPro11M4]) {
            self
        }
    }
    
    /// Quick preview - all devices
    func allDevicesPreview() -> some View {
        MultiDevicePreview(devices: PreviewDevices.all) {
            self
        }
    }
    
    /// Quick preview - custom device list
    func previewOn(devices: [PreviewDevice]) -> some View {
        MultiDevicePreview(devices: devices) {
            self
        }
    }
    
    /// Quick preview - light/dark mode comparison (using default device)
    func colorSchemePreview() -> some View {
        Group {
            MultiDevicePreview(devices: [.iPhone16Pro], colorScheme: .light) {
                self
            }
            MultiDevicePreview(devices: [.iPhone16Pro], colorScheme: .dark) {
                self
            }
        }
    }
    
    /// Quick preview - light/dark mode comparison for specific device
    func colorSchemePreview(on device: PreviewDevice) -> some View {
        Group {
            MultiDevicePreview(devices: [device], colorScheme: .light) {
                self
            }
            MultiDevicePreview(devices: [device], colorScheme: .dark) {
                self
            }
        }
    }
}
#endif
