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

public typealias PlatformWindowHandler = (PlatformWindow?) -> Void

@available(macOS 15, iOS 18, *)
extension EnvironmentValues {
  @Entry public var window: PlatformWindow?
}
