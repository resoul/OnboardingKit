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

let preview = [
    PreviewIntro(
        headline: "Welcome",
        description: "This is the intro screen",
        image: UIImage(named: "intro")
    ),
    PreviewIntro(
        headline: "Welcome",
        description: "This is the intro screen",
        image: UIImage(named: "intro")
    )
]

let viewModel = PreviewIntroViewModelImpl(items: preview)
let node = PreviewIntroNode()

let c = PreviewIntroController(viewModel: viewModel, viewNode: node)
present(c, animated: true)

```
