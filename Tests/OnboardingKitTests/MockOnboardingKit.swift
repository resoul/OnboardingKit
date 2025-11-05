import XCTest
import Combine
@testable import OnboardingKit

final class MockOnboardingViewModel: OnboardingViewModel {
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    private let currentPreviewSubject = CurrentValueSubject<OnboardingScreen?, Never>(nil)
    
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
    
    var currentPreview: AnyPublisher<OnboardingScreen?, Never> {
        currentPreviewSubject.eraseToAnyPublisher()
    }
    
    func getPreview() -> OnboardingScreen {
        OnboardingScreen(headline: "Mock", description: "Mock Description")
    }
    
    func startPreview(completion: ((_ complete: @escaping () -> Void) -> Void)?) {
        currentPreviewSubject.send(getPreview())
        completion? { [weak self] in
            self?.isLoadingSubject.send(false)
        }
    }
    
    func simulateLoadingComplete() {
        isLoadingSubject.send(false)
    }
}

final class MockOnboardingDelegate: OnboardingDelegate {
    var onHandleOnboardCompletion: ((Bool) -> Void)?
    
    func handleOnboardCompletion(isLoading: Bool) {
        onHandleOnboardCompletion?(isLoading)
    }
}
