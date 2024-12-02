//
//  UIWindowMonitorViewModifier 2.swift
//  J4uApp
//
//  Created by KA on 2024/11/28.
//


#if canImport(SwiftUI) && canImport(UIKit)

import SwiftUI

@available(iOS 18, *)
public struct UIWindowMonitorViewModifier: ViewModifier {

    @State var uiWindow: UIWindow?
    let handler: PlatformWindowHandler?

    public func body(content: Content) -> some View {
        content
        .background {
            UIWindowMonitorView.Representable { uiWindow in
              if self.uiWindow != uiWindow {
                self.uiWindow = uiWindow
                handler?(uiWindow)
              }
            }
        }
        .environment(\.window, uiWindow)
    }
}

@available(iOS 18, *)
public extension View {

    func uiWindowMonitor(_ handler: PlatformWindowHandler? = nil) -> some View {
        self
        .modifier(UIWindowMonitorViewModifier(handler: handler))
    }
}

@available(iOS 18, *)
fileprivate class UIWindowMonitorView: UIView {

    struct Representable: UIViewRepresentable {

        let handler: PlatformWindowHandler

        func makeUIView(context: Context) -> UIView {
            UIWindowMonitorView(handler: handler)
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }

    let handler: PlatformWindowHandler

    init(handler: @escaping PlatformWindowHandler) {
        self.handler = handler
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  override func draw(_ rect: CGRect) {}

  override func didMoveToWindow() {
    handler(window)
  }
}

#endif
