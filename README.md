# NavX
![Version](https://img.shields.io/badge/version-1.0.2-blue)
![SwiftUI](https://img.shields.io/badge/SwiftUI-blue)
![iOS](https://img.shields.io/badge/iOS-blue)
![Minimum iOS version](https://img.shields.io/badge/Minimum%20iOS%20version-15-blue)

An intuitive SwiftUI navigation framework designed to simplify the integration and management of custom navigation patterns. 
With the power of PageXItem and dynamic navigation bars, NavX offers developers a fluid and customizable navigation experience, 
seamlessly bridging design and functionality in modern iOS applications.

## Table of Contents
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/mkaulfers)
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

### Swift Package Manager

In Xcode, navigate to your project's settings
Select the "Swift Packages" tab
Click the "+" icon to add a new package
Paste the repository URL (https://github.com/mkaulfers/NavX.git) and click "Next"
For the version rule, select "Up to Next Major" and specify 1.0.0 as the minimum version, then click "Next"
Choose the target where you want to use the package, and then click "Finish"

### Alternatively, you can add the package directly via Xcode:

You can use The Swift Package Manager to install [NavX] by adding the proper description to your Package.swift file:

```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/YOUR_GITHUB_USERNAME/YourPackageName.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "YOUR_TARGET_NAME", dependencies: ["YourPackageName"])
    ]
)
```

Replace YOUR_PROJECT_NAME, YOUR_GITHUB_USERNAME, YourPackageName, and YOUR_TARGET_NAME with appropriate values for your project.

## Features

### NavX View

The primary navigation view that manages and displays a series of `PageXItem` views. Key features include:

```swift
NavX(selecedIndex: $selectedIndex) {...}
    .barAlignment(.center)
    .barX { bar in ... }
    .respectedBarSafeAreas(.all)
    .ignoredPageSafeAreas(.all)
    .pageScrollIndicator(.always)
```

- `barAlignment(_ value: Alignment)`: Aligns the navigation bar.
- `barX(_ newView: @escaping (any View) -> any View)`: Modify the tab bar view.
- `respectedBarSafeAreas(_ value: Edge.Set)`: Add spacing between the bottom of the `TabBar` and the top of the `PageView`.
- `ignoredPageSafeAreas(_ value: Edge.Set)`: Ignore specific safe areas, causing content to overlay the navigation stack and safe area.
- `pageScrollIndicator(_ value: ScrollIndicatorVisibility)`: Configure scroll bar visibility.

### PageX View

A concrete implementation of the `PageXItem` protocol, which represents an individual page item within the `NavX` navigation system. It provides several chaining methods to customize.
This should contain your `page content`.

```swift
NavX { ...
    PageX { ... }
    .iconX("house")
    .titleX("Home")
    .foregroundColorX(.black)
    .tabX {
        Circle()
            .fill(.gray)
            .frame(width: 40, height: 40)
    
}
```

- `iconX(_ iconName: String)`: Set an icon for the tab.
- `titleX(_ newTitle: String)`: Set the title for the tab.
- `foregroundColorX(_ newColor: Color)`: Define a custom foreground color.
- `tabX(_ newView: @escaping () -> any View)`: Offer a custom tab view.

### PageXItem Protocol

```swift
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
```

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

Using the combination of `NavX(...)` and `PageX(...)` with their respective modifiers, you can create a fully customized tab bar system.

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

We welcome contributions! Please see [CONTRIBUTING](./CONTRIBUTING.MD) for details.

## License

## Copyright

All rights reserved. This work is copyrighted to the original author.

## Permission for Non-commercial Use

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use the Software in non-commercial applications, including the rights to use, copy, and modify the Software, subject to the following conditions:

- The Software may not be used for commercial purposes without express written permission.
- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

## Commercial Use

For permission to use the Software in commercial applications, please reach out to the original author for written consent:

Email: [matt@getnovara.com](mailto:matt@getnovara.com)

## Disclaimer

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

```

