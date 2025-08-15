# CanvasKit 🎨
SwiftUI Preview 的便捷裝置預設值

一個輕量級的 Swift Package，提供預先定義的 Apple 裝置預設值，讓 SwiftUI 預覽更方便、更有效率。

## 功能特色

- ✅ **豐富的裝置預設值** - 支援最新的 iPhone、iPad、Apple Watch、Mac
- ✅ **便捷的多裝置預覽** - 一次預覽多個裝置
- ✅ **深色/淺色模式支援** - 快速對比不同主題
- ✅ **動態字型大小支援** - 測試可訪問性
- ✅ **便捷方法** - 提供多種快速預覽方法

## 系統需求

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Swift 5.9+
- Xcode 15.0+

## 安裝

### Swift Package Manager

在 Xcode 中：**File > Add Package Dependencies…**

```
https://github.com/dwhao84/CanvasKit
```

或在 `Package.swift` 中：

```swift
dependencies: [
    .package(url: "https://github.com/dwhao84/CanvasKit", from: "1.0.0")
]
```

## 使用方式

### 1. 基本單一裝置預覽
```swift
import CanvasKit

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .previewDevice(.iPhone16Pro)
    }
}
```

### 2. 多裝置預覽 (使用預設組合)
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(PreviewDevices.phones, id: \.rawValue) { device in
            MyView()
                .previewDevice(device)
        }
    }
}
```

### 3. 使用 MultiDevicePreview
```swift
import CanvasKit

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDevicePreview(devices: [.iPhone16Pro, .iPadPro11M4]) {
            MyView()
        }
    }
}
```

### 4. 便捷預覽方法
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .quickPreview()           // 常用裝置組合
            // .phonePreview()        // iPhone 16 Pro
            // .padPreview()          // iPad Pro 11" M4
            // .allDevicesPreview()   // 所有裝置
    }
}
```

### 5. 深色/淺色模式對比
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .colorSchemePreview()                    // 使用預設裝置
            // .colorSchemePreview(on: .iPhone16Pro) // 指定裝置
    }
}
```

### 6. 進階功能 - 動態字型大小
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDevicePreview(
            devices: [.iPhone16Pro],
            colorScheme: .light,
            dynamicTypeSize: DynamicTypeSize.xxxLarge
        ) {
            MyView()
        }
    }
}
```

## 可用裝置

### 預設組合
- `PreviewDevices.phones` - 常用手機
  - iPhone SE (3rd generation), iPhone 16, iPhone 16 Pro, iPhone 15 Pro Max
- `PreviewDevices.pads` - 常用平板
  - iPad mini (6th generation), iPad Pro 11-inch (M4), iPad Pro 12.9-inch (6th generation)
- `PreviewDevices.all` - 全部裝置

### iPhone 系列
```swift
.iPhone16             // iPhone 16
.iPhone16Plus         // iPhone 16 Plus  
.iPhone16Pro          // iPhone 16 Pro
.iPhone16ProMax       // iPhone 16 Pro Max
.iPhone15             // iPhone 15
.iPhone15Plus         // iPhone 15 Plus
.iPhone15Pro          // iPhone 15 Pro
.iPhone15ProMax       // iPhone 15 Pro Max
.iPhone14Pro          // iPhone 14 Pro
.iPhone14ProMax       // iPhone 14 Pro Max
.iPhoneSE3            // iPhone SE (3rd generation)
```

### iPad 系列
```swift
.iPadPro129Gen6       // iPad Pro 12.9-inch (6th generation)
.iPadPro11M4          // iPad Pro 11-inch (M4)
.iPadMini6            // iPad mini (6th generation)
.iPadAir5             // iPad Air (5th generation)
.iPad10Gen            // iPad (10th generation)
```

### Apple Watch 系列
```swift
.appleWatchUltra2     // Apple Watch Ultra 2 (49mm)
.appleWatchSeries9_45 // Apple Watch Series 9 (45mm)
```

### Mac 系列
```swift
.macStudio            // Mac Studio
```

## 便捷方法

| 方法 | 說明 |
|------|------|
| `.quickPreview()` | 常用裝置組合 (iPhone SE, iPhone 16 Pro, iPad Pro 11" M4) |
| `.phonePreview()` | iPhone 16 Pro |
| `.padPreview()` | iPad Pro 11" M4 |
| `.allDevicesPreview()` | 所有裝置 |
| `.previewOn(devices:)` | 自訂裝置列表 |
| `.colorSchemePreview()` | 深色/淺色模式對比 |
| `.colorSchemePreview(on:)` | 指定裝置的深色/淺色模式對比 |

## 注意事項

- 此套件僅在 `DEBUG` 模式下可用，不會影響正式版本
- 需要在支援 SwiftUI 的 Apple 平台上使用
- 裝置名稱需要與 Xcode 模擬器中的名稱完全一致

## 貢獻

歡迎提交 Issue 和 Pull Request！

## 授權

此專案使用 MIT 授權條款。
