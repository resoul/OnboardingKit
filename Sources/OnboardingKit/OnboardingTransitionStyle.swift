public enum OnboardingTransitionStyle {
    case fade
    case slide
    case scale
    case slideFromBottom
    case custom((OnboardingNode, @escaping () -> Void) -> Void)
}
