# CanvasKit 🎨
SwiftUI Preview 的便捷裝置預設值

## 安裝
Xcode: **File > Add Package Dependencies…**

## 使用方式

### 單一裝置預覽
```swift
import CanvasKit

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .previewDevice(.iPhone16)
    }
}
```

### 多裝置預覽
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

## 可用裝置

**預設組合：**
- `PreviewDevices.phones` - 常用手機
- `PreviewDevices.pads` - 常用平板  
- `PreviewDevices.all` - 全部裝置

**單一裝置：**
- iPhone: `.iPhone16`, `.iPhone16Pro`, `.iPhoneSE3`...
- iPad: `.iPadPro11M4`, `.iPadMini6`...
- Watch: `.appleWatchUltra2`...
- Mac: `.macStudio`
