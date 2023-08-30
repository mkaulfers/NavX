//
//  TabX.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
/// A custom navigational view that provides a tab bar interface and manages the content of each tab.
///
/// - Parameters:
///     - Content: A sequence of items that conform to `PageXItem`.
public struct NavX<Content: Sequence>: View where Content.Element == any PageXItem {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Binding var selectedIndex: Int
    @PageBuilder private var content: () -> Content
    
    /// Initializes a new `NavX` with a selected index binding and content.
    ///
    /// - Parameters:
    ///   - selectedIndex: A binding to the currently selected index.
    ///   - content: A closure that returns the sequence of `PageXItem` views to be managed.
    public init(selectedIndex: Binding<Int>, @PageBuilder content: @escaping () -> Content) {
        _selectedIndex = selectedIndex
        self.content = content
    }
    
    @State private var barHeight: CGFloat = 0
    @State private var previousIndex: Int = 0
    
    private var barAlignment: Alignment = .bottom
    private var respectedBarSafeAreas: Edge.Set = []
    private var ignoredPageSafeAreas: Edge.Set = []
    private var barX: ((any View) -> any View)?
    private var pageSafeAreaSpacing: CGFloat = 0
    private var pageScrollIndicator: ScrollIndicatorVisibility = .hidden
    
    private var safeAreaOffset: CGFloat {
        if ignoredPageSafeAreas.contains(.bottom) {
            return safeAreaInsets.bottom
        }
        
        return 0
    }
    
    public var body: some View {
        ZStack(alignment: barAlignment) {
            pageContent
            tabBarContent
                .padding(respectedBarSafeAreas, safeAreaInsets.bottom)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                barHeight = proxy.size.height
                            }
                    }
                }
        }
        .edgesIgnoringSafeArea(respectedBarSafeAreas)
        .onChange(of: selectedIndex) { index in
            previousIndex = index
        }
    }
    
    private var pageContent: some View {
        HStack {
            ForEach(Array(content().enumerated()), id: \.offset) { (index, item) in
                if index == selectedIndex {
                    ScrollView {
                        AnyView(item)
                            .tag(index)
                            .padding(respectedBarSafeAreas, barHeight + safeAreaOffset + pageSafeAreaSpacing)
                    }
                    .transition(selectedTransition(prevIndex: previousIndex, newIndex: selectedIndex))
                    .edgesIgnoringSafeArea(ignoredPageSafeAreas)
                    .scrollIndicators(.hidden)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(ignoredPageSafeAreas)
    }
    
    private var tabBarContent: some View {
        let baseContent = HStack {
            ForEach(Array(content().enumerated()), id: \.offset) { (index, item) in
                Button(action: {
                    withAnimation {
                        selectedIndex = index
                    }
                }, label: {
                    ZStack {
                        if let tabX = item.tabX {
                            AnyView(tabX())
                        }
                        
                        VStack {
                            if let icon = item.iconX {
                                Image(systemName: icon)
                            }
                            
                            if let title = item.titleX {
                                Text(title)
                            }
                        }
                    }
                })
                .foregroundColor(item.foregroundColorX ?? .white)
            }
        }
        
        if let barXModifier = barX {
            return AnyView(barXModifier(baseContent))
        }
        
        return AnyView(baseContent)
    }
    
    @discardableResult
    /// Aligns the bar to a specified alignment. Default alignment is `.bottom`.
    ///
    /// - Parameter value: The desired alignment for the bar.
    /// - Returns: A new instance of `NavX` with the bar aligned to the specified position.
    public func barAlignment(_ value: Alignment) -> NavX {
        var copy = self
        copy.barAlignment = value
        return copy
    }
    
    @discardableResult
    /// Provides a custom view modifier for the `TabBar` view.
    ///
    /// - Parameter newView: A closure that takes an input view and returns a modified view.
    /// - Returns: A new instance of `NavX` with the modified `TabBar` view.
    public func barX(_ newView: @escaping (any View) -> any View) -> NavX {
        var copy = self
        copy.barX = newView
        return copy
    }
    
    @discardableResult
    /// Adjusts the padding of the tab bar based on the provided set of edges.
    ///
    /// - Parameter value: The set of edges to which the tab bar should respect safe areas.
    /// - Returns: A new instance of `NavX` with adjusted padding.
    public func respectedBarSafeAreas(_ value: Edge.Set) -> NavX {
        var copy = self
        copy.respectedBarSafeAreas = value
        return copy
    }
    
    @discardableResult
    /// Specifies which safe areas should be ignored by the content view.
    ///
    /// - Parameter value: The set of edges for which safe areas should be ignored.
    /// - Returns: A new instance of `NavX` with specified safe areas to ignore.
    public func ignoredPageSafeAreas(_ value: Edge.Set) -> NavX {
        var copy = self
        copy.ignoredPageSafeAreas = value
        return copy
    }
    
    @discardableResult
    /// Configures the visibility of the scroll indicator for the pages.
    ///
    /// - Parameter value: The desired visibility setting for the scroll indicator.
    /// - Returns: A new instance of `NavX` with the configured scroll indicator visibility.
    public func pageScrollIndicator(_ value: ScrollIndicatorVisibility) -> NavX {
        var copy = self
        copy.pageScrollIndicator = value
        return copy
    }
    
    private func selectedTransition(prevIndex: Int, newIndex: Int) -> AnyTransition {
        if prevIndex == newIndex {
            return .identity
        }

        return AnyTransition.asymmetric(
            insertion: prevIndex < newIndex ? .move(edge: .trailing) : .move(edge: .leading),
            removal: prevIndex < newIndex ? .move(edge: .leading) : .move(edge: .trailing)
        )
    }
}
#endif

