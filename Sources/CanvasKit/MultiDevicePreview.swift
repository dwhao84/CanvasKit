//
//  File.swift
//  CanvasKit
//
//  Created by Da Wei Hao on 2025/8/15.
//

// MARK: - MultiDevicePreview

#if DEBUG && canImport(SwiftUI)
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension View {
    @ViewBuilder func withColorScheme(_ scheme: ColorScheme?) -> some View {
        if let scheme { self.environment(\.colorScheme, scheme) } else { self }
    }

    /// 套用動態字型大小（iOS 15+, macOS 12+ 已支援）
    @ViewBuilder func withDynamicTypeSizeIfAvailable(_ size: Any?) -> some View {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
        if let s = size as? DynamicTypeSize {
            self.dynamicTypeSize(s)
        } else {
            self
        }
        #else
        self
        #endif
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MultiDevicePreview<Content: View>: View {
    public let devices: [PreviewDevice]
    public let colorScheme: ColorScheme?
    private let _dynamicTypeSize: Any?   // 用 Any? 裝載，避免簽名觸發 12.0 限制
    public let content: () -> Content

    public init(
        devices: [PreviewDevice],
        colorScheme: ColorScheme? = nil,
        dynamicTypeSize: Any? = nil,     // 呼叫端在新平台傳入 DynamicTypeSize 即可
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
    
    /// 快速預覽 - 常用的幾個裝置（iPhone、iPad）
    func quickPreview() -> some View {
        MultiDevicePreview(devices: [.iPhoneSE3, .iPhone16Pro, .iPadPro11M4]) {
            self
        }
    }
    
    /// 快速預覽 - iPhone 16 Pro
    func phonePreview() -> some View {
        MultiDevicePreview(devices: [.iPhone16Pro]) {
            self
        }
    }
    
    /// 快速預覽 - iPad Pro 11" M4
    func padPreview() -> some View {
        MultiDevicePreview(devices: [.iPadPro11M4]) {
            self
        }
    }
    
    /// 快速預覽 - 所有裝置
    func allDevicesPreview() -> some View {
        MultiDevicePreview(devices: PreviewDevices.all) {
            self
        }
    }
    
    /// 快速預覽 - 自訂裝置列表
    func previewOn(devices: [PreviewDevice]) -> some View {
        MultiDevicePreview(devices: devices) {
            self
        }
    }
    
    /// 快速預覽 - 深色/淺色模式對比（使用預設裝置）
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
    
    /// 快速預覽 - 指定裝置的深色/淺色模式對比
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
