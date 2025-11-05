import Combine

public protocol OnboardingViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var currentPreview: AnyPublisher<OnboardingScreen?, Never> { get }

    func getPreview() -> OnboardingScreen
    func startPreview(completion: ((_ complete: @escaping () -> Void) -> Void)?)
}
