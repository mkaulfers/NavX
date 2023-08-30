//
//  TabX.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
public struct NavX<Content: Sequence>: View where Content.Element == any PageXItem {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Binding var selectedIndex: Int
    @PageBuilder private var content: () -> Content
    
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
    public func barAlignment(_ value: Alignment) -> NavX {
        var copy = self
        copy.barAlignment = value
        return copy
    }
    
    @discardableResult
    public func barX(_ newView: @escaping (any View) -> any View) -> NavX {
        var copy = self
        copy.barX = newView
        return copy
    }
    
    @discardableResult
    public func respectedBarSafeAreas(_ value: Edge.Set) -> NavX {
        var copy = self
        copy.respectedBarSafeAreas = value
        return copy
    }
    
    @discardableResult
    public func ignoredPageSafeAreas(_ value: Edge.Set) -> NavX {
        var copy = self
        copy.ignoredPageSafeAreas = value
        return copy
    }
    
    @discardableResult
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

