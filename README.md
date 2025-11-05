# OnboardingKit

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.5+-orange.svg" />
  <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
  <img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" />
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" />
</p>

**OnboardingKit** is a modern, flexible iOS library for creating beautiful onboarding experiences. Built with UIKit, Texture (AsyncDisplayKit), and Combine, it provides smooth animations and customizable intro screens for your app.

## ✨ Features

- 🎨 **Fully Customizable** - Colors, fonts, images, and animations
- 🔄 **Multiple Transition Styles** - Fade, slide, scale, and custom animations
- 📱 **Modern Architecture** - MVVM pattern with Combine framework
- 🚀 **High Performance** - Built on Texture for smooth 60fps animations
- 🎯 **Type-Safe** - Full Swift type safety with comprehensive error handling
- 🧩 **Easy Integration** - Simple SPM installation and minimal setup
- ♿️ **Accessible** - Support for Dynamic Type and accessibility features

## 📦 Installation

### Swift Package Manager

Add OnboardingKit to your project via Xcode or by adding it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/resoul/OnboardingKit.git", from: "0.2.0")
]
```

Or in Xcode:
1. File → Add Packages...
2. Enter repository URL
3. Select version and add to your target

## 🚀 Quick Start

### Basic Usage

```swift
import OnboardingKit

// Create onboarding screens
let screens = [
    OnboardingScreen(
        headline: "Welcome to MyApp",
        description: "Discover amazing features that will change your life",
        image: UIImage(named: "welcome"),
        transitionStyle: .fade
    ),
    OnboardingScreen(
        headline: "Stay Connected",
        description: "Connect with friends and family instantly",
        image: UIImage(named: "connect"),
        transitionStyle: .slide
    ),
    OnboardingScreen(
        headline: "Get Started",
        description: "Let's begin your journey together",
        image: UIImage(named: "start"),
        transitionStyle: .scale
    )
]

// Create view model
let viewModel = OnboardingViewModelImpl(items: screens, delay: 2.5)

// Create and present controller
let onboardingVC = OnboardingController(
    viewModel: viewModel,
    viewNode: OnboardingNode()
)
onboardingVC.delegate = self

present(onboardingVC, animated: true)
```

### Handle Completion

```swift
extension YourViewController: OnboardingDelegate {
    func handleOnboardingCompletion(isLoading: Bool) {
        if !isLoading {
            // Onboarding finished
            dismiss(animated: true) {
                // Navigate to main app
                self.showMainScreen()
            }
        }
    }
}
```

## 🎨 Customization

### Custom Colors and Fonts

```swift
let screen = OnboardingScreen(
    headline: "Beautiful Design",
    description: "Customize every aspect",
    image: UIImage(named: "design"),
    backgroundColor: .systemIndigo,
    headlineColor: .white,
    headlineFont: .boldSystemFont(ofSize: 32),
    descriptionColor: .systemGray6,
    descriptionFont: .systemFont(ofSize: 18, weight: .regular),
    transitionStyle: .fade,
    animationDuration: 1.0
)
```

### Transition Styles

OnboardingKit supports multiple built-in transition styles:

```swift
// Fade in/out
.fade

// Slide from right
.slide

// Scale up
.scale

// Slide from bottom
.slideFromBottom

// Custom animation
.custom { node, completion in
    UIView.animate(withDuration: 0.5, animations: {
        node.alpha = 0
        node.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }) { _ in
        completion()
    }
}
```

### Advanced Configuration

```swift
let viewModel = OnboardingViewModelImpl(
    items: screens,
    delay: 3.0 // Auto-advance delay in seconds
)

// With custom completion handler
viewModel.startPreview { complete in
    // Perform async task
    self.loadUserData { success in
        if success {
            complete() // Move to next screen
        }
    }
}
```
Run tests:
```bash
swift test
```
