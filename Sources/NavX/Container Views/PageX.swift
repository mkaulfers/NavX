//
//  PageX.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
public struct PageX<Content: View>: PageXItem {
    @ViewBuilder private var content: () -> Content
    public var iconX: String?
    public var titleX: String?
    public var foregroundColorX: Color?
    public var tabX: (() -> any View)?
    
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
    public func iconX(_ iconName: String) -> PageX {
        var copy = self
        copy.iconX = iconName
        return copy
    }
    
    @discardableResult
    public func titleX(_ newTitle: String) -> PageX {
        var copy = self
        copy.titleX = newTitle
        return copy
    }
    
    @discardableResult
    public func foregroundColorX(_ newColor: Color) -> PageX {
        var copy = self
        copy.foregroundColorX = newColor
        return copy
    }
    
    @discardableResult
    public func tabX(_ newView: @escaping () -> any View) -> PageX {
        var copy = self
        copy.tabX = newView
        return copy
    }
}
#endif
