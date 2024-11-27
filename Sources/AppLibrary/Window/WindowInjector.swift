//
//  WindowInjector.swift
//  swift-app-library
//
//  Created by KA on 2024/11/28.
//

import SwiftUI

public struct WindowInjector<Content: View>: View {
  public var content: Content
  public var handler: PlatformWindowHandler?
  
  public init(@ViewBuilder content: () -> Content, _ handler: PlatformWindowHandler? = nil) {
    self.content = content()
    self.handler = handler
  }
  
  public var body: some View {
#if os(macOS)
    return content
      .nsWindowMonitor(handler)
#elseif os(iOS)
    return content
      .uiWindowMonitor(handler)
#endif
  }
}
