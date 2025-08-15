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

### SwiftUI – MultiDevicePreview
快速在多台裝置、不同主題、字級下預覽你的 View。

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
        MultiDevicePreview(
            devices: [
                .init(rawValue: "iPhone 16"),
                .init(rawValue: "iPad Pro 12.9-inch (6th generation)")
            ],
            colorScheme: .light,
            dynamicTypeSize: DynamicTypeSize.large
        ) {
            MyView()
        }
    }
}
#endif
```

---

### SwiftUI – MultiTraitPreview（進階）
同時測試多裝置 × 亮/暗模式 × 不同字級。

```swift
#if DEBUG
struct MyView_TraitPreviews: PreviewProvider {
    static var previews: some View {
        MultiTraitPreview(
            devices: [
                .init(rawValue: "iPhone 16 Pro"),
                .init(rawValue: "iPad Pro 11-inch (M4)")
            ],
            colorSchemes: [.light, .dark],
            dynamicTypeSizes: [.small, .large, .accessibility3]
        ) {
            MyView()
        }
    }
}
#endif
```

> ⚠️ 提醒：多組合可能會讓 Xcode Canvas 較慢，請依需要使用。

---

### UIKit – UIViewController Preview
將 UIKit 畫面直接顯示在 SwiftUI Canvas。

```swift
import UIKit
import CanvasKit

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}

#if DEBUG
import SwiftUI

struct MyViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview {
            MyViewController()
        }
        .previewDevice("iPhone 16 Pro")
    }
}
#endif
```

---

### SwiftUI – 使用 PreviewPresets（常用裝置清單）
為了避免每次都手打 `rawValue`，你可以直接使用 `PreviewPresets` 提供的常用裝置組合。

```swift
#if DEBUG
struct MyView_PresetsPreview: PreviewProvider {
    static var previews: some View {
        MultiDevicePreview(
            devices: PreviewPresets.common, // 常用組合：iPhone Pro 系列 + iPad
            colorScheme: .dark
        ) {
            MyView()
        }
    }
}
#endif
```

#### PreviewPresets 範例內容
```swift
public enum PreviewPresets {
    // iPhone
    public static let iPhonesCompact: [PreviewDevice] = [
        .init(rawValue: "iPhone SE (3rd generation)"),
        .init(rawValue: "iPhone 16")
    ]
    public static let iPhonesProLine: [PreviewDevice] = [
        .init(rawValue: "iPhone 16 Pro"),
        .init(rawValue: "iPhone 16 Pro Max")
    ]

    // iPad
    public static let iPads: [PreviewDevice] = [
        .init(rawValue: "iPad mini (6th generation)"),
        .init(rawValue: "iPad Pro 11-inch (M4)"),
        .init(rawValue: "iPad Pro 12.9-inch (6th generation)")
    ]

    // 常用組合
    public static let common: [PreviewDevice] = iPhonesProLine + iPads
}
```

---

## 💡 小技巧
- `devices` 可傳任何 `PreviewDevice` 列表  
- `colorScheme` 支援 `.light` / `.dark`  
- `dynamicTypeSize` 需 iOS 15+ / macOS 12+  
- 可搭配 `Group` 或 `MultiTraitPreview` 一次測試更多組合  
- 建議建立自己的裝置清單（`PreviewPresets`）以減少重複輸入

---

## 📂 Folder Structure

```
CanvasKit/
├── Sources/
│   └── CanvasKit/
│       ├── MultiDevicePreview.swift
│       ├── MultiTraitPreview.swift
│       ├── UIKitPreview.swift
│       ├── PreviewPresets.swift
│       └── (other Swift files...)
├── Tests/
│   └── CanvasKitTests/
│       └── (test files...)
├── Package.swift
└── README.md
```
