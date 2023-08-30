//
//  PageBuilder.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
/// A result builder that facilitates the creation of a collection of `PageXItem` views.
/// Designed for use with `NavX` to construct its content.
///
/// This builder allows for a more declarative syntax when defining multiple page items for the navigation system.
///
/// Usage:
/// ```
/// let myPages = PageBuilder {
///     MyFirstPageView()
///     MySecondPageView()
///     // ... other page items ...
/// }
/// ```
@resultBuilder
public struct PageBuilder {

    /// Builds a collection of `PageXItem` views.
    ///
    /// - Parameter components: A variadic list of views conforming to `PageXItem`.
    /// - Returns: An array of views that conform to `PageXItem`.
    static public func buildBlock(_ components: any PageXItem...) -> [any PageXItem] {
        components
    }

    /// Builds a collection of `PageXItem` views, particularly useful for conditional view constructions.
    ///
    /// - Parameter components: A variadic list of arrays of views conforming to `PageXItem`.
    /// - Returns: An array of views that conform to `PageXItem`.
    static public func buildPartialBlock(_ components: [any PageXItem]...) -> [any PageXItem] {
        components.flatMap { $0 }
    }
}
#endif
