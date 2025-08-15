# CanvasKit 🎨
SwiftUI Preview 的便捷裝置預設值

## 系統需求
- iOS 15.0+
- macOS 12.0+
- tvOS 15.0+
- watchOS 8.0+
- Xcode 14.0+

## 安裝
Xcode: **File > Add Package Dependencies…**

```
https://github.com/dwhao84/CanvasKit
```

## 使用方式

### 基本預覽裝置
```swift
import CanvasKit

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .previewDevice(.iPhone16)
    }
}
```

### 預設裝置組合
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

### 便捷預覽方法

#### 快速預覽（常用裝置）
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .quickPreview()  // iPhone SE3, iPhone 16 Pro, iPad Pro 11" M4
    }
}
```

#### 單一裝置類型預覽
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyView().phonePreview()  // iPhone 16 Pro
            MyView().padPreview()    // iPad Pro 11" M4
        }
    }
}
```

#### 所有裝置預覽
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .allDevicesPreview()  // 所有可用裝置
    }
}
```

#### 自訂裝置列表預覽
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .previewOn(devices: [.iPhone16Pro, .iPadMini6])
    }
}
```

#### 深色/淺色模式對比預覽
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyView().colorSchemePreview()  // 預設裝置的明暗對比
            MyView().colorSchemePreview(on: .iPhone16Pro)  // 指定裝置的明暗對比
        }
    }
}
```

### MultiDevicePreview 結構體
```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDevicePreview(
            devices: [.iPhone16Pro, .iPadPro11M4],
            colorScheme: .dark
        ) {
            MyView()
        }
    }
}
```

## MultiDevicePreview 進階用法

`MultiDevicePreview` 提供更進階的多裝置預覽功能：

```swift
MultiDevicePreview(
    devices: [PreviewDevice],           // 裝置陣列
    colorScheme: ColorScheme? = nil,    // 顏色主題（可選）
    dynamicTypeSize: Any? = nil         // 動態字體大小（可選）
) {
    // 你的 View 內容
}
```

### 範例

**基本用法:**
```swift
MultiDevicePreview(devices: [.iPhone16Pro, .iPadPro11M4]) {
    MyView()
}
```

**指定顏色主題:**
```swift
MultiDevicePreview(
    devices: [.iPhone16Pro, .iPhone16ProMax],
    colorScheme: .dark
) {
    MyView()
}
```

**完整設定:**
```swift
MultiDevicePreview(
    devices: PreviewDevices.phones,
    colorScheme: .light,
    dynamicTypeSize: DynamicTypeSize.large
) {
    MyView()
}
```

## 可用裝置

### 預設組合
- `PreviewDevices.phones` - 常用手機：iPhone SE3、iPhone 16、iPhone 16 Pro、iPhone 15 Pro Max
- `PreviewDevices.pads` - 常用平板：iPad mini 6、iPad Pro 11" M4、iPad Pro 12.9" Gen6
- `PreviewDevices.all` - 全部裝置（包含所有手機和平板）

### 便捷預覽方法
- `.quickPreview()` - 常用裝置（iPhone SE3、iPhone 16 Pro、iPad Pro 11" M4）
- `.phonePreview()` - iPhone 16 Pro
- `.padPreview()` - iPad Pro 11" M4
- `.allDevicesPreview()` - 所有可用裝置
- `.colorSchemePreview()` - 深色/淺色模式對比（預設裝置）
- `.colorSchemePreview(on: device)` - 指定裝置的深色/淺色模式對比
- `.previewOn(devices: [PreviewDevice])` - 自訂裝置列表

### 單一裝置

**iPhone:**
- `.iPhone16` - iPhone 16
- `.iPhone16Plus` - iPhone 16 Plus
- `.iPhone16Pro` - iPhone 16 Pro
- `.iPhone16ProMax` - iPhone 16 Pro Max
- `.iPhone15` - iPhone 15
- `.iPhone15Plus` - iPhone 15 Plus
- `.iPhone15Pro` - iPhone 15 Pro
- `.iPhone15ProMax` - iPhone 15 Pro Max
- `.iPhone14Pro` - iPhone 14 Pro
- `.iPhone14ProMax` - iPhone 14 Pro Max
- `.iPhoneSE3` - iPhone SE (3rd generation)

**iPad:**
- `.iPadPro11M4` - iPad Pro 11-inch (M4)
- `.iPadPro129Gen6` - iPad Pro 12.9-inch (6th generation)
- `.iPadMini6` - iPad mini (6th generation)
- `.iPadAir5` - iPad Air (5th generation)
- `.iPad10Gen` - iPad (10th generation)

**Apple Watch:**
- `.appleWatchUltra2` - Apple Watch Ultra 2 (49mm)
- `.appleWatchSeries9_45` - Apple Watch Series 9 (45mm)

**Mac:**
- `.macStudio` - Mac Studio
