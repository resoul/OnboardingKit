# PreviewIntro

**PreviewIntro** is a Swift Package for building beautiful intro/preview screens on iOS,  
powered by **AsyncDisplayKit (Texture)** and Combine.

## Features
- Lightweight DTO model `PreviewIntro` with default styles.
- `PreviewIntroNode` based on **ASDisplayNode** with animations.
- `PreviewIntroViewModel` using Combine for reactive state management.

## Installation

Add the package dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/resoul/PreviewIntro.git", from: "0.1.1")
]
```
## Usage

```swift
import PreviewIntro

let previews = [
    PreviewIntro(
        headline: "Welcome",
        description: "This is the first intro screen with fade animation",
        image: UIImage(named: "intro1"),
        transitionStyle: .fade,
        animationDuration: 0.8
    ),
    PreviewIntro(
        headline: "Discover",
        description: "Explore amazing features with slide animation",
        image: UIImage(named: "intro2"),
        transitionStyle: .slide,
        animationDuration: 1.0
    ),
    PreviewIntro(
        headline: "Get Started",
        description: "Begin your journey with scale animation",
        image: UIImage(named: "intro3"),
        transitionStyle: .scale,
        animationDuration: 0.9
    ),
    PreviewIntro(
        headline: "Custom",
        description: "Custom animation example",
        image: UIImage(named: "intro4"),
        transitionStyle: .custom { node, completion in
            // Your custom animation logic
            UIView.animate(withDuration: 1.0) {
                // Animate node
            } completion: { _ in
                completion()
            }
        },
        animationDuration: 1.0
    )
]

let viewModel = PreviewIntroViewModelImpl(items: previews, delay: 2.0)
let node = PreviewIntroNode()

let c = PreviewIntroController(viewModel: viewModel, viewNode: node)
present(c, animated: true)

```
