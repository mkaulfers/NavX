//
//  PageXItem.swift
//  XBar
//
//  Created by Matthew Kaulfers on 8/29/23.
//

import SwiftUI

#if os(iOS)
/// A protocol that represents an individual page item to be used within a `NavX` navigation system.
///
/// By conforming to `PageXItem`, a view becomes suitable for integration within the `NavX` tab-based navigation interface.
/// Each `PageXItem` can provide an icon, a title, a foreground color, and a custom tab view.
public protocol PageXItem: View {
    
    /// An optional system name of the icon to be displayed on the tab bar.
    var iconX: String? { get }
    
    /// An optional title to be displayed on the tab bar.
    /// This title typically represents the content or purpose of the associated view.
    var titleX: String? { get }
    
    /// An optional foreground color for the tab item.
    /// This color will be applied to the icon and title of the tab item.
    var foregroundColorX: Color? { get }
    
    /// An optional closure that returns a custom view for the tab.
    /// This allows for more advanced customization of the tab beyond just an icon and title.
    var tabX: (() -> any View)? { get }
}
#endif
