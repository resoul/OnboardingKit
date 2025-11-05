import UIKit

public struct OnboardingScreen {
    let headline: String
    let description: String
    let image: UIImage?
    let backgroundColor: UIColor
    let headlineColor: UIColor
    let headlineFont: UIFont
    let descriptionColor: UIColor
    let descriptionFont: UIFont
    let transitionStyle: OnboardingTransitionStyle
    let animationDuration: TimeInterval

    public init(
        headline: String,
        description: String,
        image: UIImage? = nil,
        backgroundColor: UIColor = .systemBackground,
        headlineColor: UIColor = .label,
        headlineFont: UIFont = .systemFont(ofSize: 30, weight: .bold),
        descriptionColor: UIColor = .label,
        descriptionFont: UIFont = .systemFont(ofSize: 20, weight: .regular),
        transitionStyle: OnboardingTransitionStyle = .fade,
        animationDuration: TimeInterval = 0.8
    ) {
        self.headline = headline
        self.description = description
        self.image = image
        self.backgroundColor = backgroundColor
        self.headlineColor = headlineColor
        self.headlineFont = headlineFont
        self.descriptionColor = descriptionColor
        self.descriptionFont = descriptionFont
        self.transitionStyle = transitionStyle
        self.animationDuration = animationDuration
    }
}
