//
//  File.swift
//  CanvasKit
//
//  Created by Da Wei Hao on 2025/8/15.
//

// MARK: - UIKitPreviewAdapters

#if DEBUG
import SwiftUI

#if canImport(UIKit)
import UIKit

public struct UIViewControllerPreview<V: UIViewController>: UIViewControllerRepresentable {
    private let builder: () -> V
    public init(_ builder: @escaping () -> V) { self.builder = builder }
    public func makeUIViewController(context: Context) -> V { builder() }
    public func updateUIViewController(_ vc: V, context: Context) {}
}

public struct UIViewPreview<V: UIView>: UIViewRepresentable {
    private let builder: () -> V
    public init(_ builder: @escaping () -> V) { self.builder = builder }
    public func makeUIView(context: Context) -> V { builder() }
    public func updateUIView(_ view: V, context: Context) {}
}
#endif
#endif
