//
//  PageX.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
/// A representation of a page item that provides configuration options for its content and appearance.
///
/// - Parameters:
///     - Content: The type of view used for the content of the page.
public struct PageX<Content: View>: PageXItem {
    @ViewBuilder private var content: () -> Content
    public var iconX: String?
    public var titleX: String?
    public var foregroundColorX: Color?
    public var tabX: (() -> any View)?
    
    /// Creates an instance of `PageX` with the provided parameters.
    ///
    /// - Parameters:
    ///   - content: A closure that returns the content of this page.
    ///   - iconX: An optional string representing the icon's name for this page.
    ///   - titleX: An optional string representing the title of this page.
    ///   - foregroundColorX: An optional color to set the foreground color for this page.
    ///   - tabX: An optional closure that returns a view to be used as a tab for this page.
    public init(content: @escaping () -> Content,
                iconX: String? = nil,
                titleX: String? = nil,
                foregroundColorX: Color? = nil,
                tabX: (() -> any View)? = nil) {
        self.content = content
        self.iconX = iconX
        self.titleX = titleX
        self.foregroundColorX = foregroundColorX
        self.tabX = tabX
    }
    
    public var body: some View {
        content()
    }
    
    @discardableResult
    /// Updates the icon's name for this page and returns a new copy of the page with the updated value. Uses `SFSymbols`
    ///
    /// - Parameters:
    ///   - iconName: A string representing the new icon's name.
    /// - Returns: A new instance of `PageX` with the updated icon's name.
    public func iconX(_ iconName: String) -> PageX {
        var copy = self
        copy.iconX = iconName
        return copy
    }
    
    @discardableResult
    /// Updates the title for this page and returns a new copy of the page with the updated value.
    ///
    /// - Parameters:
    ///   - newTitle: A string representing the new title.
    /// - Returns: A new instance of `PageX` with the updated title.
    public func titleX(_ newTitle: String) -> PageX {
        var copy = self
        copy.titleX = newTitle
        return copy
    }
    
    @discardableResult
    /// Updates the foreground color for this page and returns a new copy of the page with the updated value.
    ///
    /// - Parameters:
    ///   - newColor: A `Color` representing the new foreground color.
    /// - Returns: A new instance of `PageX` with the updated foreground color.
    public func foregroundColorX(_ newColor: Color) -> PageX {
        var copy = self
        copy.foregroundColorX = newColor
        return copy
    }
    
    @discardableResult
    /// Updates the view to be used as a tab for this page and returns a new copy of the page with the updated value.
    ///
    /// - Parameters:
    ///   - newView: A closure that returns the new view to be used as a tab.
    /// - Returns: A new instance of `PageX` with the updated tab view.
    public func tabX(_ newView: @escaping () -> any View) -> PageX {
        var copy = self
        copy.tabX = newView
        return copy
    }
}
#endif
