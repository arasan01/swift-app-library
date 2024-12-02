//
//  NSWindowMonitorViewModifier.swift
//  J4uApp
//
//  Created by KA on 2024/11/28.
//


#if canImport(SwiftUI) && canImport(AppKit)

import SwiftUI

@available(macOS 15, *)
public struct NSWindowMonitorViewModifier: ViewModifier {

    @State var nsWindow: NSWindow?
    let handler: PlatformWindowHandler?

    public func body(content: Content) -> some View {
        content
        .background {
            NSWindowMonitorView.Representable { nsWindow in
              if self.nsWindow != nsWindow {
                self.nsWindow = nsWindow
                handler?(nsWindow)
              }
            }
        }
        .environment(\.window, nsWindow)
    }
}

@available(macOS 15, *)
public extension View {

    func nsWindowMonitor(_ handler: PlatformWindowHandler? = nil) -> some View {
        self
        .modifier(NSWindowMonitorViewModifier(handler: handler))
    }
}

@available(macOS 15, *)
fileprivate class NSWindowMonitorView: NSView {

    struct Representable: NSViewRepresentable {

        let handler: PlatformWindowHandler

        func makeNSView(context: Context) -> NSView {
            NSWindowMonitorView(handler: handler)
        }

        func updateNSView(_ nsView: NSView, context: Context) {}
    }

    let handler: PlatformWindowHandler

    init(handler: @escaping PlatformWindowHandler) {
        self.handler = handler
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {}

    override func viewDidMoveToWindow() {
        handler(window)
    }
}

#endif
