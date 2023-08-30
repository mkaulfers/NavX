//
//  PageBuilder.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
@resultBuilder
public struct PageBuilder {
    static public func buildBlock(_ components: any PageXItem...) -> [any PageXItem] {
        components
    }
    
    static public func buildPartialBlock(_ components: [any PageXItem]...) -> [any PageXItem] {
        components.flatMap { $0 }
    }
}
#endif
