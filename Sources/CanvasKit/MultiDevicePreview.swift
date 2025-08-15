//
//  File.swift
//  CanvasKit
//
//  Created by Da Wei Hao on 2025/8/15.
//

// MARK: - MultiDevicePreview

#if DEBUG
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private extension View {
    @ViewBuilder func withColorScheme(_ scheme: ColorScheme?) -> some View {
        if let scheme { self.environment(\.colorScheme, scheme) } else { self }
    }

    /// 不在簽名引用 DynamicTypeSize；在支援平台才套用
    @ViewBuilder func withDynamicTypeSizeIfAvailable(_ size: Any?) -> some View {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
        if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *),
           let s = size as? DynamicTypeSize {
            self.dynamicTypeSize(s)
        } else {
            self
        }
        #else
        self
        #endif
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
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
#endif
