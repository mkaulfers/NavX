# NavX

NavX is a custom SwiftUI navigation framework designed for easy and intuitive tab-based navigation on iOS.

## Table of Contents

- [Installation](#installation)
- [Features](#features)
    - [PageXItem Protocol](#pagexitem-protocol)
    - [PageX Struct](#pagex-struct)
    - [NavX View](#navx-view)
    - [PageBuilder](#pagebuilder)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

(Include steps on how to install or integrate your library. For instance, via Swift Package Manager, CocoaPods, etc.)

## Features

### PageXItem Protocol

A protocol that defines items suitable for the `NavX` navigation system. Each `PageXItem` can provide:

- `iconX`: An optional icon to be displayed on the tab bar.
- `titleX`: An optional title representing the content or purpose of the view.
- `foregroundColorX`: A custom foreground color for the tab item.
- `tabX`: A closure returning a custom view for advanced tab customization.

### PageX Struct

A concrete implementation of the `PageXItem` protocol, which represents an individual page item within the `NavX` navigation system. It provides several chaining methods to customize:

- `iconX(_ iconName: String)`: Set an icon for the tab.
- `titleX(_ newTitle: String)`: Set the title for the tab.
- `foregroundColorX(_ newColor: Color)`: Define a custom foreground color.
- `tabX(_ newView: @escaping () -> any View)`: Offer a custom tab view.

### NavX View

The primary navigation view that manages and displays a series of `PageXItem` views. Key features include:

- `barAlignment(_ value: Alignment)`: Aligns the navigation bar.
- `barX(_ newView: @escaping (any View) -> any View)`: Modify the tab bar view.
- `respectedBarSafeAreas(_ value: Edge.Set)`: Add spacing between the bottom of the `TabBar` and the top of the `PageView`.
- `ignoredPageSafeAreas(_ value: Edge.Set)`: Ignore specific safe areas, causing content to overlay the navigation stack and safe area.
- `pageScrollIndicator(_ value: ScrollIndicatorVisibility)`: Configure scroll bar visibility.

### PageBuilder

A result builder for SwiftUI that facilitates the creation of `PageXItem` collections. It allows for a more declarative syntax when defining multiple page items for the navigation system.

## Usage

```swift
let navView = NavX(selectedIndex: .constant(0)) {
    PageX {
        Text("First Page")
    }
    .iconX("house")
    .titleX("Home")

    PageX {
        Text("Second Page")
    }
    .iconX("person")
    .titleX("Profile")
}

```
## Advanced Usage

```swift
NavX(selectedIndex: $selectedIndex) {
    PageX {
        Color.red
            .frame(height: UIScreen.main.bounds.height)
    }
    .foregroundColorX(.black)
    .tabX {
        Circle()
            .fill(.gray)
            .frame(width: 40, height: 40)
    }
    
    PageX {
        Color.blue
            .frame(height: UIScreen.main.bounds.height)
    }
    .foregroundColorX(.black)
    .titleX("B")
    .iconX("person.circle")
    
    PageX {
        Color.green
            .frame(height: UIScreen.main.bounds.height)
    }
    .foregroundColorX(.yellow)
    .tabX {
        Rectangle()
            .fill(.red)
            .frame(width: 50, height: 50)
    }
}
.ignoredPageSafeAreas(.top)
.respectedBarSafeAreas(.bottom)
.barX { bar in
    bar.padding()
        .background {
            Color.white
        }
        .cornerRadius(5)
        .shadow(radius: 5)
}
```

## Contributing

We welcome contributions! Please see CONTRIBUTING.md for details.

## License

(Include your licensing information here. E.g., "NavX is available under the MIT license. See the LICENSE file for more info.")
```

