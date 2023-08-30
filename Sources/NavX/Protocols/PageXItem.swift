//
//  PageXItem.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
public protocol PageXItem: View {
    var iconX: String? { get }
    var titleX: String? { get }
    var foregroundColorX: Color? { get }
    var tabX: (() -> any View)? { get }
}
#endif
