# CanvasKit 🎨
Lightweight SwiftUI & UIKit preview toolkit for Xcode Canvas.

## ✨ Features
- 📱 Multi-device previews (iPhone, iPad, Mac)
- 🌗 Theme switching (Light/Dark mode)
- 📝 Dynamic type sizes
- 🔄 Orientation testing
- 🖼 UIKit previews

## 🚀 Installation
1. In Xcode: **File > Add Package Dependencies…**
2. Enter your package repository URL

---

## 📖 Usage

### SwiftUI – 簡潔的裝置預覽
使用 CanvasKit 提供的便捷 PreviewDevice 擴展，無需手打裝置名稱。

```swift
import SwiftUI
import CanvasKit

struct MyView: View {
    var body: some View {
        VStack {
            Text("Hello CanvasKit!")
                .padding()
        }
    }
}

#if DEBUG
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyView()
                .previewDevice(.iPhone16)
                .previewDisplayName("iPhone 16")
            
            MyView()
                .previewDevice(.iPadPro11M4)
                .previewDisplayName("iPad Pro 11")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
```

---

### SwiftUI – 使用預設裝置組合
使用 `PreviewDevices` 提供的預設裝置組合進行批量預覽。

```swift
#if DEBUG
struct MyView_MultipleDevices: PreviewProvider {
    static var previews: some View {
        ForEach(PreviewDevices.phones, id: \.rawValue) { device in
            MyView()
                .previewDevice(device)
                .previewDisplayName(device.rawValue ?? "Unknown Device")
        }
    }
}
#endif
```

---

### 可用的預設裝置組合

```swift
// 手機裝置
PreviewDevices.phones // iPhone SE 3, iPhone 16, iPhone 16 Pro, iPhone 15 Pro Max

// 平板裝置
PreviewDevices.pads   // iPad mini 6, iPad Pro 11 M4, iPad Pro 12.9 Gen6

// 所有裝置
PreviewDevices.all    // 包含所有手機和平板
```

---

### 可用的單一裝置預設值

```swift
// iPhone 系列
.iPhone16, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax
.iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax
.iPhone14Pro, .iPhone14ProMax, .iPhoneSE3

// iPad 系列
.iPadPro129Gen6, .iPadPro11M4, .iPadMini6, .iPadAir5, .iPad10Gen

// Apple Watch 系列
.appleWatchUltra2, .appleWatchSeries9_45

// Mac 系列
.macStudio
```

---

## 💡 小技巧
- 使用 `.iPhone16`、`.iPadPro11M4` 等預設裝置，避免手打裝置名稱
- 善用 `PreviewDevices.phones`、`PreviewDevices.pads` 等組合進行批量預覽
- 可搭配 `Group` 或 `ForEach` 一次測試多種組合
- 支援 `.preferredColorScheme(.dark)` 切換深色模式
- 支援 Apple Watch 和 Mac 裝置預覽

---

## 📂 Project Structure

```
CanvasKit/
├── Sources/
│   └── CanvasKit/
│       ├── CanvasKit.swift              // PreviewDevice 擴展 & PreviewDevices
│       ├── MultiDevicePreview.swift     // 多裝置預覽元件
│       └── UIKitPreviewAdapters.swift   // UIKit 預覽適配器
├── Tests/
│   └── CanvasKitTests/
│       └── CanvasKitTests.swift
├── Package.swift
└── README.md
```
