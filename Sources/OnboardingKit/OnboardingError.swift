import Foundation

public enum OnboardingError: LocalizedError {
    case emptyItems
    case invalidDelay
    case invalidAnimationDuration(TimeInterval)

    public var errorDescription: String? {
        switch self {
        case .emptyItems:
            return "Onboarding items cannot be empty. Please provide at least one item."
        case .invalidDelay:
            return "Delay must be a positive value greater than 0."
        case .invalidAnimationDuration(let duration):
            return "Animation duration must be between 0.1 and 5.0 seconds. Provided: \(duration)"
        }
    }
}
