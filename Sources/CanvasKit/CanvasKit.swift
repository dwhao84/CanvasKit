// The Swift Programming Language
// https://docs.swift.org/swift-book

// MARK: - CanvasKit
#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension PreviewDevice {
    // MARK: - iPhone
    static let iPhone16             = PreviewDevice(rawValue: "iPhone 16")
    static let iPhone16Plus         = PreviewDevice(rawValue: "iPhone 16 Plus")
    static let iPhone16Pro          = PreviewDevice(rawValue: "iPhone 16 Pro")
    static let iPhone16ProMax       = PreviewDevice(rawValue: "iPhone 16 Pro Max")
    static let iPhone15ProMax       = PreviewDevice(rawValue: "iPhone 15 Pro Max")
    static let iPhoneSE3            = PreviewDevice(rawValue: "iPhone SE (3rd generation)")
    static let iPhone15             = PreviewDevice(rawValue: "iPhone 15")
    static let iPhone15Plus         = PreviewDevice(rawValue: "iPhone 15 Plus")
    static let iPhone15Pro          = PreviewDevice(rawValue: "iPhone 15 Pro")
    static let iPhone14Pro          = PreviewDevice(rawValue: "iPhone 14 Pro")
    static let iPhone14ProMax       = PreviewDevice(rawValue: "iPhone 14 Pro Max")

    // MARK: - iPad
    static let iPadPro129Gen6       = PreviewDevice(rawValue: "iPad Pro 12.9-inch (6th generation)")
    static let iPadPro11M4          = PreviewDevice(rawValue: "iPad Pro 11-inch (M4)")
    static let iPadMini6            = PreviewDevice(rawValue: "iPad mini (6th generation)")
    static let iPadAir5             = PreviewDevice(rawValue: "iPad Air (5th generation)")
    static let iPad10Gen            = PreviewDevice(rawValue: "iPad (10th generation)")

    // MARK: - Apple Watch
    static let appleWatchUltra2     = PreviewDevice(rawValue: "Apple Watch Ultra 2 (49mm)")
    static let appleWatchSeries9_45 = PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)")

    // MARK: - Mac
    static let macStudio            = PreviewDevice(rawValue: "Mac Studio")
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public enum PreviewDevices {
    public static let phones: [PreviewDevice] = [
        .iPhoneSE3, .iPhone16, .iPhone16Pro, .iPhone15ProMax
    ]

    public static let pads: [PreviewDevice] = [
        .iPadMini6, .iPadPro11M4, .iPadPro129Gen6
    ]

    /// 所有裝置（方便一次跑全部）
    public static let all: [PreviewDevice] = phones + pads
}
#endif

