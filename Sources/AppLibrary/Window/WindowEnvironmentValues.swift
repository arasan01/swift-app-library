//
//  WindowEnvironmentValues.swift
//  J4uApp
//
//  Created by KA on 2024/11/28.
//

import SwiftUI

#if canImport(AppKit)
public typealias PlatformWindow = NSWindow
#elseif canImport(UIKit)
public typealias PlatformWindow = UIWindow
#endif

@available(macOS 15, iOS 18, *)
extension EnvironmentValues {
  @Entry public var window: PlatformWindow?
}

public typealias PlatformWindowHandler = (PlatformWindow?) -> Void

public struct WindowInjector: ViewModifier {
  public var handler: PlatformWindowHandler?
  
  public init(_ handler: PlatformWindowHandler? = nil) {
    self.handler = handler
  }
  
  public func body(content: Content) -> some View {
    #if os(macOS)
    return content
      .nsWindowMonitor(handler)
    #elseif os(iOS)
    return content
      .uiWindowMonitor(handler)
    #endif
  }
}
